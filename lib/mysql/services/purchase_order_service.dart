import 'package:flutter_interview_application/mysql/remote_database_service.dart';
import 'package:injectable/injectable.dart';

import '../../core/models/purchase_order.dart';

@LazySingleton()
class PurchaseOrderService {
  Future<List<PurchaseOrder>> getPurchaseOrders() async {
    final result = await RemoteDatabaseService.conn!.execute("SELECT * FROM purchase_orders");
    return result.rows.map((row) => PurchaseOrder.fromJson(row.assoc())).toList();
  }
}
