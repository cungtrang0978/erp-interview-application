import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_application/core/exceptions/network_exception.dart';
import 'package:flutter_interview_application/core/utils/jwt_utils.dart';
import 'package:flutter_interview_application/main.dart';
import 'package:mysql_client/mysql_client.dart';

import '../exceptions/login_exception.dart';
import '../models/customer.dart';
import '../models/inventory.dart';
import '../models/login_response.dart';
import '../models/product.dart';
import '../models/sale_order.dart';
import '../models/sale_order_item.dart';
import '../models/user.dart';
import '../models/warehouse.dart';

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

  /// Optional: Method to close the connection
  Future<void> dispose() async {
    await _conn?.close();
    _conn = null;
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

  /// Fetch Sale Order Details & Items by ID (Including Product Name)
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

  /// **Create Sale Order**
  Future<int?> createSaleOrder(SaleOrder saleOrder) async {
    if (_conn == null) throw Exception("Database connection not initialized!");

    // Insert Sale Order
    final orderId = await _insertSaleOrder(saleOrder);

    // Insert Order Items & Update Inventory
    for (var item in saleOrder.items) {
      await _insertSaleOrderItem(orderId, item);
      await _updateInventory(item);
      await _logInventoryTransaction(orderId, item);
    }

    return orderId;
  }

  /// **1️⃣ Insert Sale Order and Return Order ID**
  Future<int> _insertSaleOrder(SaleOrder saleOrder) async {
    var result = await _conn!.execute(
      """
      INSERT INTO sales_orders (customer_id, order_date, expected_delivery_date, status, 
        shipping_address, billing_address, payment_terms, currency, total_amount, tax_amount, 
        shipping_amount, notes) 
      VALUES (:customer_id, :order_date, :expected_delivery_date, :status, :shipping_address, 
        :billing_address, :payment_terms, :currency, :total_amount, :tax_amount, :shipping_amount, :notes)
      """,
      {
        "customer_id": saleOrder.customerId.toString(),
        "order_date": saleOrder.orderDate.toIso8601String(),
        "expected_delivery_date": saleOrder.expectedDeliveryDate?.toIso8601String() ?? "",
        "status": saleOrder.status,
        "shipping_address": saleOrder.shippingAddress,
        "billing_address": saleOrder.billingAddress,
        "payment_terms": saleOrder.paymentTerms ?? "",
        "currency": saleOrder.currency ?? "USD",
        "total_amount": saleOrder.totalAmount.toString(),
        "tax_amount": saleOrder.taxAmount.toString(),
        "shipping_amount": saleOrder.shippingAmount.toString(),
        "notes": saleOrder.notes ?? "",
      },
    );

    return result.lastInsertID.toInt();
  }

  /// **2️⃣ Insert Sale Order Item**
  Future<void> _insertSaleOrderItem(int orderId, SaleOrderItem item) async {
    await _conn!.execute(
      """
      INSERT INTO sales_order_items (sales_order_id, product_id, quantity, unit_price, discount_percentage, 
        tax_percentage, warehouse_id, status) 
      VALUES (:sales_order_id, :product_id, :quantity, :unit_price, :discount_percentage, :tax_percentage, 
        :warehouse_id, :status)
      """,
      {
        "sales_order_id": orderId.toString(),
        "product_id": item.productId.toString(),
        "quantity": item.quantity.toString(),
        "unit_price": item.unitPrice.toString(),
        "discount_percentage": item.discountPercentage.toString(),
        "tax_percentage": item.taxPercentage.toString(),
        "warehouse_id": item.warehouseId.toString(),
        "status": "PENDING",
      },
    );
  }

  /// **3️⃣ Update Inventory After Sale**
  Future<void> _updateInventory(SaleOrderItem item) async {
    await _conn!.execute(
      """
      UPDATE inventory 
      SET quantity_on_hand = quantity_on_hand - :quantity, 
          quantity_reserved = quantity_reserved + :quantity
      WHERE product_id = :product_id AND warehouse_id = :warehouse_id
      """,
      {
        "quantity": item.quantity.toString(),
        "product_id": item.productId.toString(),
        "warehouse_id": item.warehouseId.toString(),
      },
    );
  }

  /// **4️⃣ Log Inventory Transaction**
  Future<void> _logInventoryTransaction(int orderId, SaleOrderItem item) async {
    await _conn!.execute(
      """
      INSERT INTO inventory_transactions (product_id, warehouse_id, transaction_type, quantity, reference_type, reference_id, notes)
      VALUES (:product_id, :warehouse_id, 'ISSUE', :quantity, 'SALES ORDER', :sales_order_id, 'Sale order deduction')
      """,
      {
        "product_id": item.productId.toString(),
        "warehouse_id": item.warehouseId.toString(),
        "quantity": item.quantity.toString(),
        "sales_order_id": orderId.toString(),
      },
    );
  }

  Future<List<Customer>> getCustomers() async {
    if (_conn == null) throw Exception("Database connection not initialized!");

    var result = await _conn!.execute("SELECT * FROM customers");

    return result.rows.map((row) => Customer.fromJson(row.assoc())).toList();
  }

  /// 1️⃣ Fetch Products
  Future<List<Product>> getProducts() async {
    if (_conn == null) throw Exception("Database connection not initialized!");

    var result = await _conn!.execute("""
    SELECT p.*, c.name AS category_name 
    FROM products p 
    LEFT JOIN product_categories c ON p.category_id = c.category_id
  """);

    return result.rows.map((row) => Product.fromJson(row.assoc())).toList();
  }

  /// 2️⃣ Fetch Warehouses
  Future<List<Warehouse>> getWarehouses() async {
    if (_conn == null) throw Exception("Database connection not initialized!");

    var result = await _conn!.execute("SELECT * FROM warehouses");

    return result.rows.map((row) => Warehouse.fromJson(row.assoc())).toList();
  }

  /// 3️⃣ Fetch Inventory for a Specific Product & Warehouse
  Future<Inventory?> getInventoryByProductAndWarehouse(int productId, int warehouseId) async {
    if (_conn == null) throw Exception("Database connection not initialized!");

    var result = await _conn!.execute("""
    SELECT * FROM inventory 
    WHERE product_id = :product_id AND warehouse_id = :warehouse_id
  """, {
      "product_id": productId.toString(),
      "warehouse_id": warehouseId.toString(),
    });

    if (result.numOfRows == 0) return null;

    return Inventory.fromJson(result.rows.first.assoc());
  }
}
