import 'package:injectable/injectable.dart';

import '../../../models/inventory.dart';
import '../../../models/sale_order_item.dart';
import '../remote_database_service.dart';

@LazySingleton()
class InventoryService {
  /// **3️⃣ Update Inventory After Sale**
  Future<void> updateInventory(SaleOrderItem item) async {
    await RemoteDatabaseService.conn!.execute(
      """
      UPDATE inventory 
      SET quantity_on_hand = quantity_on_hand - :quantity, 
          quantity_reserved = quantity_reserved + :quantity
      WHERE product_id = :product_id AND warehouse_id = :warehouse_id
      """,
      {
        "quantity": item.quantity.toString(),
        "product_id": item.productId.toString(),
        "warehouse_id": item.warehouseId.toString(),
      },
    );
  }

  /// **4️⃣ Log Inventory Transaction**
  Future<void> logInventoryTransaction(int orderId, SaleOrderItem item) async {
    await RemoteDatabaseService.conn!.execute(
      """
      INSERT INTO inventory_transactions (product_id, warehouse_id, transaction_type, quantity, reference_type, reference_id, notes)
      VALUES (:product_id, :warehouse_id, 'ISSUE', :quantity, 'SALES ORDER', :sales_order_id, 'Sale order deduction')
      """,
      {
        "product_id": item.productId.toString(),
        "warehouse_id": item.warehouseId.toString(),
        "quantity": item.quantity.toString(),
        "sales_order_id": orderId.toString(),
      },
    );
  }

  /// 3️⃣ Fetch Inventory for a Specific Product & Warehouse
  Future<Inventory?> getInventoryByProductAndWarehouse(int productId, int warehouseId) async {
    if (RemoteDatabaseService.conn == null) throw Exception("Database connection not initialized!");

    var result = await RemoteDatabaseService.conn!.execute("""
    SELECT * FROM inventory 
    WHERE product_id = :product_id AND warehouse_id = :warehouse_id
  """, {
      "product_id": productId.toString(),
      "warehouse_id": warehouseId.toString(),
    });

    if (result.numOfRows == 0) return null;

    return Inventory.fromJson(result.rows.first.assoc());
  }
}
