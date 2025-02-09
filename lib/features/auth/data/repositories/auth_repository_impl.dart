import 'package:dartz/dartz.dart';
import 'package:flutter_interview_application/core/models/login_response.dart';
import 'package:flutter_interview_application/core/models/user.dart';
import 'package:flutter_interview_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/failure.dart';
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
  Future<Either<Failure, LoginResponse>> signInWithEmail(String email, String password, bool rememberMe) async {
    try {
      final response = await _authDataSource.loginUser(email, password, rememberMe);
      return Right(response);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
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
