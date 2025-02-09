part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

final class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [];
}

final class RegisterSuccess extends RegisterState {
  @override
  List<Object> get props => [];
}

final class RegisterError extends RegisterState {
  final String message;
  const RegisterError(this.message);

  @override
  List<Object> get props => [message];
}
