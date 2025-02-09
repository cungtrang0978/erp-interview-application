part of 'login_cubit.dart';

class LoginState extends Equatable {
  final BaseStatus status;
  final String message;

  const LoginState({
    this.status = BaseStatus.initial,
    this.message = "",
  });

  LoginState copyWith({
    BaseStatus? status,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  LoginState loading() {
    return copyWith(status: BaseStatus.loading, message: "");
  }

  LoginState success() {
    return copyWith(status: BaseStatus.success, message: "");
  }

  LoginState error(String message) {
    return copyWith(status: BaseStatus.error, message: message);
  }

  @override
  List<Object> get props => [status, message];
}
