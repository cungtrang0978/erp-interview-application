import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/features/customer/domain/repositories/customer_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/customer.dart';

part 'create_sale_order_info_state.dart';

@injectable
class CreateSaleOrderInfoCubit extends Cubit<CreateSaleOrderInfoState> {
  final CustomerRepository _customerRepo;

  CreateSaleOrderInfoCubit(this._customerRepo) : super(CreateSaleOrderInfoInitial());

  Future<void> fetchCustomers() async {
    emit(CreateSaleOrderInfoLoading());

    try {
      final customers = await _customerRepo.getCustomers();
      emit(CreateSaleOrderInfoLoaded(customers));
    } catch (e) {
      emit(CreateSaleOrderInfoError(e.toString()));
    }
  }
}
