import '../../../../core/models/purchase_order.dart';

abstract class PurchaseOrderRepository {
  Future<List<PurchaseOrder>> getPurchaseOrders();
}
