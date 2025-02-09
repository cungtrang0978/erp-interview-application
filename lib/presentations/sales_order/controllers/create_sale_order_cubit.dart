import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/domain/repositories/sale_order_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/sale_order.dart';

part 'create_sale_order_state.dart';

@injectable
class CreateSaleOrderCubit extends Cubit<CreateSaleOrderState> {
  final SaleOrderRepository _saleOrderRepository;

  CreateSaleOrderCubit(this._saleOrderRepository) : super(CreateSaleOrderInitial());

  Future<void> createSaleOrder(SaleOrder saleOrder) async {
    emit(CreateSaleOrderLoading());

    try {
      int? orderId = await _saleOrderRepository.createSaleOrder(saleOrder);

      emit(CreateSaleOrderSuccess(orderId));
    } catch (e) {
      emit(CreateSaleOrderFailure("Error: ${e.toString()}"));
    }
  }
}
