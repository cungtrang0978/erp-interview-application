import 'package:flutter_interview_application/data/datasources/purchase_order_datasource.dart';
import 'package:injectable/injectable.dart';

import '../../core/models/purchase_order.dart';
import '../../domain/repositories/purchase_order_repository.dart';

@LazySingleton(as: PurchaseOrderRepository)
class PurchaseOrderRepositoryImpl implements PurchaseOrderRepository {
  final PurchaseOrderDataSource _purchaseOrderDataSource;

  PurchaseOrderRepositoryImpl(this._purchaseOrderDataSource);

  @override
  Future<List<PurchaseOrder>> getPurchaseOrders() async {
    final orders = await _purchaseOrderDataSource.getPurchaseOrders();
    return orders;
  }
}
