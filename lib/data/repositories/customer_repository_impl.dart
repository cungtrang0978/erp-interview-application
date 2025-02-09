import 'package:flutter_interview_application/core/models/customer.dart';
import 'package:flutter_interview_application/domain/repositories/customer_repository.dart';
import 'package:injectable/injectable.dart';

import '../datasources/customer_datasource.dart';

@LazySingleton(as: CustomerRepository)
class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerDataSource _customerDataSource;

  CustomerRepositoryImpl(this._customerDataSource);

  @override
  Future<List<Customer>> getCustomers() async {
    return await _customerDataSource.getCustomers();
  }
}
