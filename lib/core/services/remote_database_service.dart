import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_application/core/exceptions/network_exception.dart';
import 'package:flutter_interview_application/core/utils/jwt_utils.dart';
import 'package:flutter_interview_application/main.dart';
import 'package:mysql_client/mysql_client.dart';

import '../exceptions/login_exception.dart';
import '../models/login_response.dart';
import '../models/sale_order.dart';
import '../models/sale_order_item.dart';
import '../models/user.dart';

class RemoteDatabaseService {
  static RemoteDatabaseService? _instance;
  static MySQLConnection? _conn;

  RemoteDatabaseService._();

  static RemoteDatabaseService get instance {
    _instance ??= RemoteDatabaseService._();
    return _instance!;
  }

  Future<void> init() async {
    if (_conn != null) return; // Prevent multiple initializations

    debugPrint("Connecting to database...");
    try {
      _conn = await MySQLConnection.createConnection(
        host: flavorSettings.mysqlHost,
        port: flavorSettings.port,
        userName: flavorSettings.userName,
        password: flavorSettings.password,
        databaseName: flavorSettings.databaseName,
        secure: false,
      );
      await _conn!.connect();
      debugPrint("Connected to database.");
    } catch (e) {
      debugPrint("Error connecting to database: $e");
    }
  }

  /// Register user method
  Future<bool> registerUser(String email, String password, String name) async {
    if (_conn == null) {
      throw StateError('Database connection not initialized. Call init() first.');
    }
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    var result = await _conn!.execute(
      "INSERT INTO users (email, password, name) VALUES (:email, :password, :name)",
      {"email": email, "password": hashedPassword, "name": name},
    );
    return result.affectedRows > BigInt.zero;
  }

  /// Login user method
  Future<LoginResponse> loginUser(String email, String password) async {
    if (_conn == null) {
      throw StateError('Database connection not initialized. Call init() first.');
    }

    try {
      var result = await _conn!.execute(
        "SELECT password, id, name FROM users WHERE email = :email",
        {"email": email},
      );

      if (result.numOfRows == 0) throw LoginException("User not found");

      final first = result.rows.first;
      String storedPassword = first.colByName('password')!;
      int userId = int.parse(first.colByName('id')!);
      String name = first.colByName('name')!;

      if (BCrypt.checkpw(password, storedPassword)) {
        // 🔥 Hash password check needed (bcrypt)
        String token = JwtUtils.generateJwt(userId, email);
        return LoginResponse(
            token,
            User(
              id: userId,
              email: email,
              name: name,
            ));
      }
      throw LoginException("Invalid password");
    } catch (e) {
      if (e is LoginException) rethrow;

      throw NetworkException(e.toString());
    }
  }

  Future<List<Map<String, String?>>> getSalesOrders() async {
    if (_conn == null) throw Exception("Database not initialized!");

    var result = await _conn!.execute("SELECT * FROM sales_orders");
    return result.rows.map((row) => row.assoc()).toList();
  }

  // Fetch Sale Order Details & Items by ID (Including Product Name)
  Future<SaleOrder?> getSalesOrderDetailById(int salesOrderId) async {
    if (_conn == null) throw Exception("Database connection not initialized!");

    // Fetch Sale Order Details
    var orderResult = await _conn!.execute(
      "SELECT * FROM sales_orders WHERE sales_order_id = :sales_order_id",
      {"sales_order_id": salesOrderId.toString()},
    );

    if (orderResult.numOfRows == 0) return null; // Order not found

    var orderData = orderResult.rows.first.assoc();
    SaleOrder saleOrder = SaleOrder.fromJson(orderData);

    // Fetch Sale Order Items (Including Product Name)
    var itemsResult = await _conn!.execute(
      """
      SELECT soi.*, p.name AS product_name
      FROM sales_order_items soi
      JOIN products p ON soi.product_id = p.product_id
      WHERE soi.sales_order_id = :sales_order_id
      """,
      {"sales_order_id": salesOrderId.toString()},
    );

    List<SaleOrderItem> items = itemsResult.rows.map((row) => SaleOrderItem.fromJson(row.assoc())).toList();

    // Attach items to SaleOrder
    return saleOrder.copyWith(items: items);
  }

  // Optional: Method to close the connection
  Future<void> dispose() async {
    await _conn?.close();
    _conn = null;
  }
}
