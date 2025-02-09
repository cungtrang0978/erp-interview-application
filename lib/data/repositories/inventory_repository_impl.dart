import 'package:flutter_interview_application/core/models/inventory.dart';
import 'package:flutter_interview_application/data/datasources/inventory_datasource.dart';
import 'package:injectable/injectable.dart';

import '../../core/models/sale_order_item.dart';
import '../../domain/repositories/inventory_repository.dart';

@LazySingleton(as: InventoryRepository)
class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryDataSource _inventoryDataSource;

  InventoryRepositoryImpl(this._inventoryDataSource);

  @override
  Future<void> updateInventory(SaleOrderItem item) {
    return _inventoryDataSource.updateInventory(item);
  }

  @override
  Future<Inventory?> getInventoryByProductAndWarehouse(int productId, int warehouseId) async {
    return await _inventoryDataSource.getInventoryByProductAndWarehouse(productId, warehouseId);
  }
}
