import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/base/base_status.dart';
import 'package:flutter_interview_application/features/auth/domain/usecase/login_with_email_pw.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginWithEmailPassword _loginWithEmailPassword;

  LoginCubit(this._loginWithEmailPassword) : super(LoginState());

  Future<void> submit(String email, String password, bool rememberMe) async {
    emit(state.loading());
    final fold = await _loginWithEmailPassword.call(LoginWithEmailPasswordParams(email, password, rememberMe));
    fold.fold((l) {
      emit(state.error(l.message));
    }, (r) {
      emit(state.success());
    });
  }
}
