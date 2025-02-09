import 'package:flutter/material.dart';
import 'package:flutter_interview_application/main.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql_client/mysql_client.dart';

@lazySingleton
class RemoteDatabaseService {
  static MySQLConnection? conn;

  Future<void> init() async {
    if (conn != null) return; // Prevent multiple initializations

    debugPrint("Connecting to database...");
    try {
      conn = await MySQLConnection.createConnection(
        host: flavorSettings.mysqlHost,
        port: flavorSettings.port,
        userName: flavorSettings.userName,
        password: flavorSettings.password,
        databaseName: flavorSettings.databaseName,
        secure: false,
      );
      await conn!.connect();
      debugPrint("Connected to database.");
    } catch (e) {
      debugPrint("Error connecting to database: $e");
      rethrow;
    }
  }

  /// Optional: Method to close the connection
  Future<void> dispose() async {
    await conn?.close();
    conn = null;
  }
}
