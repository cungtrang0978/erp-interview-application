import 'package:injectable/injectable.dart';

import '../../../../core/models/purchase_order.dart';
import '../../../../core/services/remote/services/purchase_order_service.dart';

@LazySingleton()
class PurchaseOrderDataSource {
  final PurchaseOrderService _purchaseOrderService;

  PurchaseOrderDataSource(this._purchaseOrderService);

  Future<List<PurchaseOrder>> getPurchaseOrders() async {
    return await _purchaseOrderService.getPurchaseOrders();
  }
}
