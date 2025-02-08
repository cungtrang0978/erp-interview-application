class Inventory {
  final int inventoryId;
  final int productId;
  final int warehouseId;
  final int quantityOnHand;
  final int quantityReserved;

  const Inventory({
    required this.inventoryId,
    required this.productId,
    required this.warehouseId,
    required this.quantityOnHand,
    required this.quantityReserved,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      inventoryId: int.parse(json['inventory_id'] ?? '0'),
      productId: int.parse(json['product_id'] ?? '0'),
      warehouseId: int.parse(json['warehouse_id'] ?? '0'),
      quantityOnHand: int.parse(json['quantity_on_hand'] ?? '0'),
      quantityReserved: int.parse(json['quantity_reserved'] ?? '0'),
    );
  }
}
