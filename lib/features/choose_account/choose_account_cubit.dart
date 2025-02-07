import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/base/base_status.dart';
import 'package:flutter_interview_application/core/models/login_response.dart';
import 'package:flutter_interview_application/core/services/local_database_service.dart';
import 'package:flutter_interview_application/core/utils/jwt_utils.dart';

import '../../core/models/user.dart';

part 'choose_account_state.dart';

class ChooseAccountCubit extends Cubit<ChooseAccountState> {
  ChooseAccountCubit(List<User> users) : super(ChooseAccountState.initial()) {
    _init(users);
  }

  void _init(List<User> users) async {
    final accounts = <LoginResponse>[];
    for (final user in users) {
      final token = await LocalDatabaseService.instance.getJwtByUser(user);
      if (token != null) {
        final isExpired = JwtUtils.checkExpired(token);
        accounts.add(LoginResponse(token, user, isExpired: isExpired));
      }
    }

    emit(state.copyWith(accounts: accounts));
  }

  Future<void> selectUser(LoginResponse account) async {
    emit(state.loading(account));

    final jwtByAccount = await LocalDatabaseService.instance.getJwtByUser(account.user);
    if (jwtByAccount == null) {
      emit(state.failure("Invalid saved account"));
      return;
    }
    final isExpired = JwtUtils.checkExpired(jwtByAccount);
    if (isExpired) {
      emit(state.failure("This account's session has expired"));
    } else {
      await LocalDatabaseService.instance.updateJwt(jwtByAccount);
      emit(state.success());
    }
  }
}
