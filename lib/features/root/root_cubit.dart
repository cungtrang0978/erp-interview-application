import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/user.dart';
import '../../core/services/local_database_service.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(RootInitial());

  Future<void> checkAccounts() async {
    emit(RootLoading());

    final accounts = LocalDatabaseService.instance.getUsers();
    if (accounts.isEmpty) {
      emit(RootNoAccounts());
      return;
    }
    emit(RootAccountsNotEmpty(accounts));
  }
}
