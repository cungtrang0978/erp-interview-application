part of 'sale_order_detail_cubit.dart';

sealed class SaleOrderDetailState extends Equatable {
  const SaleOrderDetailState();
}

final class SaleOrderDetailInitial extends SaleOrderDetailState {
  @override
  List<Object> get props => [];
}

final class SaleOrderDetailLoading extends SaleOrderDetailState {
  @override
  List<Object> get props => [];
}

final class SaleOrderDetailError extends SaleOrderDetailState {
  final String message;

  const SaleOrderDetailError(this.message);

  @override
  List<Object> get props => [message];
}

final class SaleOrderDetailLoaded extends SaleOrderDetailState {
  final SaleOrder saleOrder;

  const SaleOrderDetailLoaded(this.saleOrder);

  @override
  List<Object> get props => [saleOrder];
}
