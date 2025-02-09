import 'package:flutter_interview_application/core/models/login_response.dart';

import '../../core/models/user.dart';

abstract class AuthRepository {
  Future<LoginResponse> signInWithEmail(String email, String password, bool rememberMe);

  Future<bool> signUpWithEmail(String email, String password, String name);

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String> getCurrentUser();

  Future<String?> getJwtByUser(User user);

  Future<void> updateJwt(String jwtByAccount);

  List<User> getLocalUsers();
}
