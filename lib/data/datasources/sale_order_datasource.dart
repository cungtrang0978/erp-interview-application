import 'package:injectable/injectable.dart';

import '../../core/models/sale_order.dart';
import '../../core/services/remote/services/inventory_service.dart';
import '../../core/services/remote/services/sale_order_service.dart';

@LazySingleton()
class SaleOrderDataSource {
  final SaleOrderService _saleOrderService;
  final InventoryService _inventoryService;

  SaleOrderDataSource(this._saleOrderService, this._inventoryService);

  Future<int> createSaleOrder(SaleOrder saleOrder) async {
    final orderId = await _saleOrderService.insertSaleOrder(saleOrder);

    // Insert Order Items & Update Inventory
    for (var item in saleOrder.items) {
      await _saleOrderService.insertSaleOrderItem(orderId, item);
      await _inventoryService.updateInventory(item);
      await _inventoryService.logInventoryTransaction(orderId, item);
    }
    return orderId;
  }

  Future<List<SaleOrder>> getSaleOrders() async {
    return await _saleOrderService.getSalesOrders();
  }

  /// Fetch Sale Order Details & Items by ID (Including Product Name)
  Future<SaleOrder?> getSaleOrderDetailById(int salesOrderId) async {
    final saleOrder = await _saleOrderService.getSaleOrderById(salesOrderId);
    if (saleOrder == null) return null;

    final items = await _saleOrderService.getSalesOrderItems(salesOrderId);
    return saleOrder.copyWith(items: items);
  }

  Future<void> updateSaleOrder(SaleOrder saleOrder) {
    throw "Not implement yet";
  }

  Future<void> deleteSaleOrder(int id) {
    throw "Not implement yet";
  }
}
