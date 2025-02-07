import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_application/core/exceptions/network_exception.dart';
import 'package:flutter_interview_application/core/utils/jwt_utils.dart';
import 'package:flutter_interview_application/main.dart';
import 'package:mysql_client/mysql_client.dart';

import '../exceptions/login_exception.dart';
import '../models/login_response.dart';
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
      //TODO: Using .env file to store sensitive information
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

  // Optional: Method to close the connection
  Future<void> dispose() async {
    await _conn?.close();
    _conn = null;
  }
}
