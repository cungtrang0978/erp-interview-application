import '../../core/models/inventory.dart';
import '../../core/models/sale_order_item.dart';

abstract class InventoryRepository {
  Future<void> updateInventory(SaleOrderItem item);

  Future<Inventory?> getInventoryByProductAndWarehouse(int productId, int warehouseId);
}
