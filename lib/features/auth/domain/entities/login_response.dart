import 'package:flutter_interview_application/core/models/user.dart';

class LoginResponse {
  final String token;
  final User user;
  final bool isExpired;

  LoginResponse(this.token, this.user, {this.isExpired = false});

  LoginResponse copyWith({
    String? token,
    User? user,
    bool? isExpired,
  }) {
    return LoginResponse(
      token ?? this.token,
      user ?? this.user,
      isExpired: isExpired ?? this.isExpired,
    );
  }
}
