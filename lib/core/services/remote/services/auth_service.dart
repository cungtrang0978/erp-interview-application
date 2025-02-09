import 'package:bcrypt/bcrypt.dart';
import 'package:injectable/injectable.dart';

import '../../../exceptions/login_exception.dart';
import '../../../exceptions/network_exception.dart';
import '../../../models/login_response.dart';
import '../../../models/user.dart';
import '../../../utils/jwt_utils.dart';
import '../remote_database_service.dart';

@LazySingleton()
class AuthService {
  /// Register user method
  Future<bool> registerUser(String email, String password, String name) async {
    if (RemoteDatabaseService.conn == null) {
      throw StateError('Database RemoteDatabaseService.connection not initialized. Call init() first.');
    }
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    var result = await RemoteDatabaseService.conn!.execute(
      "INSERT INTO users (email, password, name) VALUES (:email, :password, :name)",
      {"email": email, "password": hashedPassword, "name": name},
    );
    return result.affectedRows > BigInt.zero;
  }

  /// Login user method
  Future<LoginResponse> loginUser(String email, String password) async {
    if (RemoteDatabaseService.conn == null) {
      throw StateError('Database RemoteDatabaseService.connection not initialized. Call init() first.');
    }

    try {
      var result = await RemoteDatabaseService.conn!.execute(
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
}
