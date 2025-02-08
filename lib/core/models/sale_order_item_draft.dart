import 'product.dart';
import 'warehouse.dart';

class SaleOrderItemDraft {
  final int? salesOrderId;
  final Warehouse warehouse;
  final Product product;
  final int quantity;
  final double unitPrice;
  final double discountPercentage;
  final double taxPercentage;
  final String status;

  const SaleOrderItemDraft({
    this.salesOrderId,
    required this.product,
    required this.warehouse,
    required this.quantity,
    required this.unitPrice,
    this.discountPercentage = 0.0,
    this.taxPercentage = 0.0,
    this.status = 'PENDING',
  });

  // Convert SaleOrderItemDraft Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'sales_order_id': salesOrderId,
      'product_id': product,
      'warehouse_id': warehouse,
      'quantity': quantity,
      'unit_price': unitPrice,
      'discount_percentage': discountPercentage,
      'tax_percentage': taxPercentage,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'SaleOrderItem{salesOrderId: $salesOrderId, warehouseId: $warehouse, productId: $product, quantity: $quantity, unitPrice: $unitPrice, discountPercentage: $discountPercentage, taxPercentage: $taxPercentage, status: $status}';
  }
}
