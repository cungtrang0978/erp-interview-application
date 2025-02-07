import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/sale_order.dart';
import '../../../core/services/remote_database_service.dart';

part 'sale_order_list_state.dart';

class SaleOrderListCubit extends Cubit<SaleOrderListState> {
  SaleOrderListCubit() : super(SaleOrderListInitial());

  Future<void> fetchSaleOrders() async {
    emit(SaleOrderListLoading());
    try {
      final data = await RemoteDatabaseService.instance.getSalesOrders();
      final saleOrders = data.map((e) => SaleOrder.fromJson(e)).toList();
      emit(SaleOrderListLoaded(saleOrders));
    } catch (e) {
      emit(SaleOrderListError(e.toString()));
    }
  }
}
