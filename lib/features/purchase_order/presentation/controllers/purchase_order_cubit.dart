import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/features/purchase_order/domain/repositories/purchase_order_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/purchase_order.dart';

part 'purchase_order_state.dart';

@injectable
class PurchaseOrderCubit extends Cubit<PurchaseOrderState> {
  final PurchaseOrderRepository _purchaseOrderRepository;

  PurchaseOrderCubit(this._purchaseOrderRepository) : super(PurchaseOrderInitial());

  Future<void> fetchPurchaseOrders() async {
    emit(PurchaseOrderLoading());
    try {
      final orders = await _purchaseOrderRepository.getPurchaseOrders();
      emit(PurchaseOrderLoaded(orders));
    } catch (e) {
      emit(PurchaseOrderError("Failed to load purchase orders"));
    }
  }
}
