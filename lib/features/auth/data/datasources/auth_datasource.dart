import 'package:flutter_interview_application/core/exceptions/register_exception.dart';
import 'package:flutter_interview_application/core/models/user.dart';
import 'package:flutter_interview_application/core/services/local/local_database_service.dart';
import 'package:flutter_interview_application/core/services/remote/services/auth_service.dart';
import 'package:flutter_interview_application/features/auth/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql_client/exception.dart';

@LazySingleton()
class AuthDataSource {
  final AuthService _authService;
  final LocalDatabaseService _localDatabaseService;

  AuthDataSource(this._authService, this._localDatabaseService);

  Future<void> registerUser(String email, String password, String name) async {
    try {
      return await _authService.registerUser(email, password, name);
    } on MySQLServerException catch (e) {
      if (e.errorCode == 1062) {
        throw RegisterException('This email has already been registered.');
      }
      rethrow;
    }
  }

  Future<LoginResponseModel> loginUser(
      String email, String password, bool rememberMe) async {
    try {
      final result = await _authService.loginUser(email, password);
      final loginRes = LoginResponseModel.fromJson(result);
      if (rememberMe) {
        await _localDatabaseService.saveUser(loginRes.user, loginRes.token);
      } else {
        await _localDatabaseService.saveJwtOnly(loginRes.user, loginRes.token);
      }
      return loginRes;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    throw "Not implement yet";
  }

  Future<String?> getJwtByUser(User user) async {
    return await _localDatabaseService.getJwtByUser(user);
  }

  Future<void> updateJwt(String jwtByAccount) async {
    return await _localDatabaseService.updateJwt(jwtByAccount);
  }

  List<User> getLocalUsers() {
    return _localDatabaseService.getUsers();
  }
}
