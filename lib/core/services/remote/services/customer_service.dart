import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../models/customer.dart';
import '../remote_database_service.dart';

@LazySingleton()
class CustomerService {
  Future<List<Customer>> getCustomers() async {
    var result = await RemoteDatabaseService.execute("SELECT * FROM customers");

    return result.rows.map((row) => Customer.fromJson(row.assoc())).toList();
  }
}
