import 'package:injectable/injectable.dart';

import '../../../models/customer.dart';
import '../remote_database_service.dart';

@LazySingleton()
class CustomerService {
  Future<List<Customer>> getCustomers() async {
    if (RemoteDatabaseService.conn == null) throw Exception("Database connection not initialized!");

    var result = await RemoteDatabaseService.conn!.execute("SELECT * FROM customers");

    return result.rows.map((row) => Customer.fromJson(row.assoc())).toList();
  }
}
