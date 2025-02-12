import 'package:dartz/dartz.dart';
import 'package:flutter_interview_application/core/base/failure.dart';
import 'package:flutter_interview_application/core/base/use_case.dart';
import 'package:flutter_interview_application/features/auth/domain/entities/login_response.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

@injectable
class LoginWithEmailPassword extends UseCase<LoginResponse, LoginWithEmailPasswordParams> {
  final AuthRepository repository;

  LoginWithEmailPassword(this.repository);

  @override
  Future<Either<Failure, LoginResponse>> call(LoginWithEmailPasswordParams params) async {
    return await repository.signInWithEmail(params.email, params.password, params.rememberMe);
  }
}

class LoginWithEmailPasswordParams {
  final String email;
  final String password;
  final bool rememberMe;

  LoginWithEmailPasswordParams(this.email, this.password, this.rememberMe);
}
