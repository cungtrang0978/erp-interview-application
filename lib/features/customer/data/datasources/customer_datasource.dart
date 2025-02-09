import 'package:injectable/injectable.dart';

import '../../../../core/models/customer.dart';
import '../../../../core/services/remote/services/customer_service.dart';

@LazySingleton()
class CustomerDataSource {
  final CustomerService _customerService;

  CustomerDataSource(this._customerService);

  Future<List<Customer>> getCustomers() async {
    return await _customerService.getCustomers();
  }
}
