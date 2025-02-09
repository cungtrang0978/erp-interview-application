import '../../../../core/models/customer.dart';

abstract class CustomerRepository {
  Future<List<Customer>> getCustomers();
}
