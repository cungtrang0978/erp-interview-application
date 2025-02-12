import 'package:flutter_interview_application/features/auth/domain/entities/login_response.dart';
import 'package:flutter_interview_application/core/models/user.dart';

class LoginResponseModel extends LoginResponse {
  LoginResponseModel(super.token, super.user);

  factory LoginResponseModel.fromJson(Map<String, dynamic> data) {
    return LoginResponseModel(
      data['token'] ?? '',
      User.fromJson(data['user']),
    );
  }
}
