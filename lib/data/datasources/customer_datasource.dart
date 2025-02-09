import 'package:flutter_interview_application/mysql/services/customer_service.dart';
import 'package:injectable/injectable.dart';

import '../../core/models/customer.dart';

@LazySingleton()
class CustomerDataSource {
  final CustomerService _customerService;

  CustomerDataSource(this._customerService);

  Future<List<Customer>> getCustomers() async {
    return await _customerService.getCustomers();
  }
}
