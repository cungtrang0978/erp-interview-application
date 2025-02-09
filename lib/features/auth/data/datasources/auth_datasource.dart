import 'package:flutter_interview_application/core/models/user.dart';
import 'package:flutter_interview_application/core/services/local/local_database_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/login_response.dart';
import '../../../../core/services/remote/services/auth_service.dart';

@LazySingleton()
class AuthDataSource {
  final AuthService _authService;
  final LocalDatabaseService _localDatabaseService;

  AuthDataSource(this._authService, this._localDatabaseService);

  Future<bool> registerUser(String email, String password, String name) async {
    return await _authService.registerUser(email, password, name);
  }

  Future<LoginResponse> loginUser(String email, String password, bool rememberMe) async {
    final res = await _authService.loginUser(email, password);
    if (rememberMe) {
      await _localDatabaseService.saveUser(res.user, res.token);
    } else {
      await _localDatabaseService.saveJwtOnly(res.user, res.token);
    }
    return res;
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
