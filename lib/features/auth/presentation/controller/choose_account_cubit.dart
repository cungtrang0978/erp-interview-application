import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/base/base_status.dart';
import 'package:flutter_interview_application/features/auth/domain/entities/login_response.dart';
import 'package:flutter_interview_application/core/models/user.dart';
import 'package:flutter_interview_application/core/utils/jwt_utils.dart';
import 'package:flutter_interview_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

part 'choose_account_state.dart';

@injectable
class ChooseAccountCubit extends Cubit<ChooseAccountState> {
  final AuthRepository _authRepository;

  ChooseAccountCubit(this._authRepository) : super(ChooseAccountState.initial());

  void init(List<User>? users) async {
    users ??= _authRepository.getLocalUsers();
    final accounts = <LoginResponse>[];
    for (final user in users) {
      final token = await _authRepository.getJwtByUser(user);
      if (token != null) {
        final isExpired = JwtUtils.checkExpired(token);
        accounts.add(LoginResponse(token, user, isExpired: isExpired));
      }
    }

    emit(state.copyWith(accounts: accounts));
  }

  Future<void> selectUser(LoginResponse account) async {
    emit(state.loading(account));

    final jwtByAccount = await _authRepository.getJwtByUser(account.user);
    if (jwtByAccount == null) {
      emit(state.failure("Invalid saved account"));
      return;
    }
    final isExpired = JwtUtils.checkExpired(jwtByAccount);
    if (isExpired) {
      emit(state.failure("This account's session has expired"));
    } else {
      await _authRepository.updateJwt(jwtByAccount);
      emit(state.success());
    }
  }
}
