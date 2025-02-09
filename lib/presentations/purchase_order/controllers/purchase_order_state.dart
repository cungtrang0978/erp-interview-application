part of 'purchase_order_cubit.dart';

abstract class PurchaseOrderState {}

class PurchaseOrderInitial extends PurchaseOrderState {}

class PurchaseOrderLoading extends PurchaseOrderState {}

class PurchaseOrderLoaded extends PurchaseOrderState {
  final List<PurchaseOrder> orders;
  PurchaseOrderLoaded(this.orders);
}

class PurchaseOrderError extends PurchaseOrderState {
  final String message;
  PurchaseOrderError(this.message);
}
