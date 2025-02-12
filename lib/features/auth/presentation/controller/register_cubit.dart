import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/exceptions/register_exception.dart';
import 'package:flutter_interview_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit(this._authRepository) : super(RegisterInitial());

  Future<void> submit(
    String email,
    String password,
    String name,
  ) async {
    emit(RegisterLoading());
    try {
      await _authRepository.signUpWithEmail(email, password, name);
    } on RegisterException catch (e) {
      emit(RegisterError(e.message));
    } catch (e) {
      emit(RegisterError("Registration failed"));
    }
  }
}
