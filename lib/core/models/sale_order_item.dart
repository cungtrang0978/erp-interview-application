class SaleOrderItem {
  final int salesOrderItemId;
  final int salesOrderId;
  final int productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double discountPercentage;
  final double taxPercentage;
  final int warehouseId;
  final String status;

  const SaleOrderItem({
    required this.salesOrderItemId,
    required this.salesOrderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.discountPercentage,
    required this.taxPercentage,
    required this.warehouseId,
    required this.status,
  });

  // Convert JSON to SaleOrderItem Object
  factory SaleOrderItem.fromJson(Map<String, dynamic> json) {
    return SaleOrderItem(
      salesOrderItemId: int.tryParse(json['sales_order_item_id'] ?? '') ?? 0,
      salesOrderId: int.tryParse(json['sales_order_id'] ?? '') ?? 0,
      productId: int.tryParse(json['product_id'] ?? '') ?? 0,
      productName: json['product_name'] ?? 'Unknown Product',
      quantity: int.tryParse(json['quantity'] ?? '') ?? 0,
      unitPrice: double.tryParse(json['unit_price'] ?? '') ?? 0.0,
      discountPercentage: double.tryParse(json['discount_percentage'] ?? '') ?? 0.0,
      taxPercentage: double.tryParse(json['tax_percentage'] ?? '') ?? 0.0,
      warehouseId: int.tryParse(json['warehouse_id'] ?? '') ?? 0,
      status: json['status'] ?? '',
    );
  }

  @override
  String toString() {
    return 'SaleOrderItem(productName: $productName, quantity: $quantity, unitPrice: $unitPrice)';
  }
}
