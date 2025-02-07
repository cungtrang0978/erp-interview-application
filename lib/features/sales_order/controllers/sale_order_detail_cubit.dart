import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/sale_order.dart';
import '../../../core/services/remote_database_service.dart';

part 'sale_order_detail_state.dart';

class SaleOrderDetailCubit extends Cubit<SaleOrderDetailState> {
  SaleOrderDetailCubit() : super(SaleOrderDetailInitial());

  Future<void> fetchSaleOrderDetail(SaleOrder saleOrder) async {
    emit(SaleOrderDetailLoading());

    try {
      final data = await RemoteDatabaseService.instance.getSalesOrderDetailById(saleOrder.salesOrderId);
      if (data == null) {
        emit(SaleOrderDetailError('Data not found'));
        return;
      }
      emit(SaleOrderDetailLoaded(data));
    } catch (e) {
      emit(SaleOrderDetailError(e.toString()));
    }
  }
}
