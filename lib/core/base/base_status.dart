enum BaseStatus {
  initial,
  loading,
  success,
  error,
}

extension BaseStatusX on BaseStatus {
  bool get isInitial => this == BaseStatus.initial;
  bool get isLoading => this == BaseStatus.loading;
  bool get isSuccess => this == BaseStatus.success;
  bool get isError => this == BaseStatus.error;
}
