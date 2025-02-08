class Product {
  final int productId;
  final String name;
  final String sku;
  final String unitOfMeasure;
  final String? categoryName;

  const Product({
    required this.productId,
    required this.name,
    required this.sku,
    required this.unitOfMeasure,
    this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: int.parse(json['product_id'] ?? '0'),
      name: json['name'] ?? '',
      sku: json['sku'] ?? '',
      unitOfMeasure: json['unit_of_measure'] ?? '',
      categoryName: json['category_name'],
    );
  }
}
