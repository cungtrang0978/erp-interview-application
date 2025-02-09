import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/sale_order.dart';
import '../../domain/repositories/sale_order_repository.dart';

part 'sale_order_list_state.dart';

@injectable
class SaleOrderListCubit extends Cubit<SaleOrderListState> {
  final SaleOrderRepository _saleOrderRepository;

  SaleOrderListCubit(this._saleOrderRepository) : super(SaleOrderListInitial());

  Future<void> fetchSaleOrders() async {
    emit(SaleOrderListLoading());
    try {
      final saleOrders = await _saleOrderRepository.fetchAllSaleOrders();
      emit(SaleOrderListLoaded(saleOrders));
    } catch (e) {
      emit(SaleOrderListError(e.toString()));
    }
  }
}
