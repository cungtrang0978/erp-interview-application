part of 'choose_account_cubit.dart';

class ChooseAccountState extends Equatable {
  final List<LoginResponse> accounts;
  final BaseStatus status;
  final Object? error;
  final LoginResponse? selectedAccount;

  const ChooseAccountState({required this.accounts, required this.status, required this.error, this.selectedAccount});

  const ChooseAccountState.initial() : this(accounts: const [], status: BaseStatus.initial, error: '');

  @override
  List<Object?> get props => [accounts, status, error, selectedAccount];

  ChooseAccountState copyWith({
    List<LoginResponse>? accounts,
    BaseStatus? status,
    String? error,
    LoginResponse? selectedAccount,
  }) {
    return ChooseAccountState(
      accounts: accounts ?? this.accounts,
      status: status ?? this.status,
      error: error ?? this.error,
      selectedAccount: selectedAccount ?? this.selectedAccount,
    );
  }

  ChooseAccountState loading(LoginResponse account) {
    return copyWith(
      status: BaseStatus.loading,
      error: '',
      selectedAccount: account,
    );
  }

  ChooseAccountState failure(String message) {
    return copyWith(status: BaseStatus.error, error: message);
  }

  ChooseAccountState success() {
    return copyWith(status: BaseStatus.success, error: '');
  }
}
