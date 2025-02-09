import 'package:flutter_interview_application/core/models/login_response.dart';
import 'package:flutter_interview_application/core/models/user.dart';
import 'package:flutter_interview_application/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../datasources/auth_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<String> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> signInWithEmail(String email, String password, bool rememberMe) async {
    return await _authDataSource.loginUser(email, password, rememberMe);
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<bool> signUpWithEmail(String email, String password, String name) async {
    return await _authDataSource.registerUser(email, password, name);
  }

  @override
  Future<String?> getJwtByUser(User user) async {
    return await _authDataSource.getJwtByUser(user);
  }

  @override
  Future<void> updateJwt(String jwtByAccount) async {
    await _authDataSource.updateJwt(jwtByAccount);
  }

  @override
  List<User> getLocalUsers() {
    return _authDataSource.getLocalUsers();
  }
}
