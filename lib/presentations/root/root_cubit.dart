import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../core/models/user.dart';

part 'root_state.dart';

@injectable
class RootCubit extends Cubit<RootState> {
  final AuthRepository _authRepository;

  RootCubit(this._authRepository) : super(RootInitial());

  Future<void> checkAccounts() async {
    emit(RootLoading());

    final accounts = _authRepository.getLocalUsers();
    if (accounts.isEmpty) {
      emit(RootNoAccounts());
      return;
    }
    emit(RootAccountsNotEmpty(accounts));
  }
}
