import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlavorSettings {
  final String mysqlHost;
  final int port;
  final String userName;
  final String password;
  final String databaseName;

  FlavorSettings({
    required this.mysqlHost,
    required this.port,
    required this.userName,
    required this.password,
    required this.databaseName,
  });

  static Future<FlavorSettings> fromEnv() async {
    await dotenv.load(fileName: ".env");

    // someBool is a bool
    final host = dotenv.get('HOST', fallback: '');
    final port = dotenv.getInt('PORT', fallback: 0);
    final userName = dotenv.get('USER_NAME', fallback: '');
    final pw = dotenv.get('PASSWORD', fallback: '');
    final database = dotenv.get('DATABASE_NAME', fallback: '');
    return FlavorSettings(
      mysqlHost: host,
      port: port,
      userName: userName,
      password: pw,
      databaseName: database,
    );
  }
}
