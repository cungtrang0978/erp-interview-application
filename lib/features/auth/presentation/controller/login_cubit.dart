import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/base/base_status.dart';
import 'package:flutter_interview_application/core/exceptions/login_exception.dart';
import 'package:flutter_interview_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState());

  Future<void> submit(String email, String password, bool rememberMe) async {
    emit(state.loading());
    try {
      await _authRepository.signInWithEmail(email, password, rememberMe);

      emit(state.success());
    } on LoginException catch (e) {
      log(e.toString());
      emit(state.error(e.message));
    } catch (e) {
      log(e.toString());
      emit(state.error(e.toString()));
    }
  }
}
