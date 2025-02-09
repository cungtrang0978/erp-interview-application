import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/sale_order.dart';
import '../../../domain/repositories/sale_order_repository.dart';

part 'sale_order_detail_state.dart';

@injectable
class SaleOrderDetailCubit extends Cubit<SaleOrderDetailState> {
  final SaleOrderRepository _saleOrderRepository;

  SaleOrderDetailCubit(this._saleOrderRepository) : super(SaleOrderDetailInitial());

  Future<void> fetchSaleOrderDetail(SaleOrder saleOrder) async {
    emit(SaleOrderDetailLoading());

    try {
      final data = await _saleOrderRepository.fetchSaleOrderDetailById(saleOrder.salesOrderId);
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
