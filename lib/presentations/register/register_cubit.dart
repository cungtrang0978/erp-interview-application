import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/remote_database_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> submit(
    String email,
    String password,
    String name,
  ) async {
    emit(RegisterLoading());
    try {
      bool success = await RemoteDatabaseService.instance.registerUser(email, password, name);
      if (success) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterError("Registration failed"));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
