part of 'sale_order_list_cubit.dart';

sealed class SaleOrderListState extends Equatable {
  const SaleOrderListState();
}

final class SaleOrderListInitial extends SaleOrderListState {
  @override
  List<Object> get props => [];
}

final class SaleOrderListLoading extends SaleOrderListState {
  @override
  List<Object> get props => [];
}

final class SaleOrderListError extends SaleOrderListState {
  final String message;

  const SaleOrderListError(this.message);

  @override
  List<Object> get props => [message];
}

final class SaleOrderListLoaded extends SaleOrderListState {
  final List<SaleOrder> saleOrders;

  const SaleOrderListLoaded(this.saleOrders);

  @override
  List<Object> get props => [saleOrders];
}
