import 'package:flutter_interview_application/core/services/remote/remote_database_service.dart';
import 'package:injectable/injectable.dart';

import '../../../models/product.dart';

@LazySingleton()
class ProductService {
  /// 1️⃣ Fetch Products
  Future<List<Product>> getProducts() async {
    var result = await RemoteDatabaseService.execute("""
    SELECT p.*, c.name AS category_name 
    FROM products p 
    LEFT JOIN product_categories c ON p.category_id = c.category_id
  """);

    return result.rows.map((row) => Product.fromJson(row.assoc())).toList();
  }
}
