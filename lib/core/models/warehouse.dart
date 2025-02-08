class Warehouse {
  final int warehouseId;
  final String name;
  final String address;

  const Warehouse({
    required this.warehouseId,
    required this.name,
    required this.address,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      warehouseId: int.parse(json['warehouse_id'] ?? '0'),
      name: json['name'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
