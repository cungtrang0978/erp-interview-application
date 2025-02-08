import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/sale_order.dart';
import '../../../core/services/remote_database_service.dart';

part 'create_sale_order_state.dart';

class CreateSaleOrderCubit extends Cubit<CreateSaleOrderState> {
  CreateSaleOrderCubit() : super(CreateSaleOrderInitial());

  Future<void> createSaleOrder(SaleOrder saleOrder) async {
    emit(CreateSaleOrderLoading());

    try {
      int? orderId = await RemoteDatabaseService.instance.createSaleOrder(saleOrder);

      if (orderId != null) {
        emit(CreateSaleOrderSuccess(orderId));
      } else {
        emit(CreateSaleOrderFailure("Failed to create sale order."));
      }
    } catch (e) {
      emit(CreateSaleOrderFailure("Error: ${e.toString()}"));
    }
  }
}
