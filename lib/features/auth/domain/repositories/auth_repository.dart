import 'package:dartz/dartz.dart';
import 'package:flutter_interview_application/features/auth/domain/entities/login_response.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> signInWithEmail(String email, String password, bool rememberMe);

  Future<void> signUpWithEmail(String email, String password, String name);

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String> getCurrentUser();

  Future<String?> getJwtByUser(User user);

  Future<void> updateJwt(String jwtByAccount);

  List<User> getLocalUsers();
}
