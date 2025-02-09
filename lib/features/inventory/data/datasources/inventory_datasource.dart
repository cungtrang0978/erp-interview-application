import 'package:flutter_interview_application/core/models/inventory.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/sale_order_item.dart';
import '../../../../core/services/remote/services/inventory_service.dart';

@LazySingleton()
class InventoryDataSource {
  final InventoryService _inventoryService;

  InventoryDataSource(this._inventoryService);

  Future<void> updateInventory(SaleOrderItem item) async {
    await _inventoryService.updateInventory(item);
  }

  Future<Inventory?> getInventoryByProductAndWarehouse(int productId, int warehouseId) async {
    return await _inventoryService.getInventoryByProductAndWarehouse(productId, warehouseId);
  }
}
