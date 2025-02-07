import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/base/base_status.dart';
import 'package:flutter_interview_application/core/exceptions/login_exception.dart';
import 'package:flutter_interview_application/core/services/local_database_service.dart';

import '../../core/services/remote_database_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> submit(String email, String password, bool rememberMe) async {
    emit(state.loading());
    try {
      final res = await RemoteDatabaseService.instance.loginUser(email, password);
      if (rememberMe) {
        await LocalDatabaseService.instance.saveUser(res.user, res.token);
      } else {
        await LocalDatabaseService.instance.saveJwtOnly(res.user, res.token);
      }
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
