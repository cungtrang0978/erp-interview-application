part of 'root_cubit.dart';

sealed class RootState extends Equatable {
  const RootState();
}

final class RootInitial extends RootState {
  @override
  List<Object> get props => [];
}

final class RootLoading extends RootState {
  @override
  List<Object> get props => [];
}

final class RootError extends RootState {
  final String message;

  const RootError(this.message);

  @override
  List<Object> get props => [message];
}

final class RootAccountsNotEmpty extends RootState {
  final List<User> users;

  const RootAccountsNotEmpty(this.users);

  @override
  List<Object> get props => [users];
}

final class RootNoAccounts extends RootState {
  @override
  List<Object> get props => [];
}
