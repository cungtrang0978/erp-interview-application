import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/customer.dart';
import '../../../core/services/remote_database_service.dart';

part 'create_sale_order_info_state.dart';

class CreateSaleOrderInfoCubit extends Cubit<CreateSaleOrderInfoState> {
  CreateSaleOrderInfoCubit() : super(CreateSaleOrderInfoInitial());

  Future<void> fetchCustomers() async {
    emit(CreateSaleOrderInfoLoading());

    try {
      final customers = await RemoteDatabaseService.instance.getCustomers();
      emit(CreateSaleOrderInfoLoaded(customers));
    } catch (e) {
      emit(CreateSaleOrderInfoError(e.toString()));
    }
  }
}
