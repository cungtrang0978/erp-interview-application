part of 'create_sale_order_cubit.dart';

abstract class CreateSaleOrderState {}

class CreateSaleOrderInitial extends CreateSaleOrderState {}

class CreateSaleOrderLoading extends CreateSaleOrderState {}

class CreateSaleOrderSuccess extends CreateSaleOrderState {
  final int orderId;

  CreateSaleOrderSuccess(this.orderId);
}

class CreateSaleOrderFailure extends CreateSaleOrderState {
  final String errorMessage;

  CreateSaleOrderFailure(this.errorMessage);
}
