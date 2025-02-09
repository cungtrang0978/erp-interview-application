import 'package:injectable/injectable.dart';

import '../../core/models/product.dart';
import '../../mysql/services/product_service.dart';

@LazySingleton()
class ProductDataSource {
  final ProductService _productService;

  ProductDataSource(this._productService);

  Future<List<Product>> getProducts() async {
    return await _productService.getProducts();
  }
}
