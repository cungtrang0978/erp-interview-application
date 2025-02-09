part of 'create_sale_order_info_cubit.dart';

sealed class CreateSaleOrderInfoState extends Equatable {
  const CreateSaleOrderInfoState();
}

final class CreateSaleOrderInfoInitial extends CreateSaleOrderInfoState {
  @override
  List<Object> get props => [];
}

final class CreateSaleOrderInfoLoading extends CreateSaleOrderInfoState {
  @override
  List<Object> get props => [];
}

final class CreateSaleOrderInfoError extends CreateSaleOrderInfoState {
  final String message;

  const CreateSaleOrderInfoError(this.message);

  @override
  List<Object> get props => [message];
}

final class CreateSaleOrderInfoLoaded extends CreateSaleOrderInfoState {
  final List<Customer> customers;

  const CreateSaleOrderInfoLoaded(this.customers);

  @override
  List<Object> get props => [customers];
}
