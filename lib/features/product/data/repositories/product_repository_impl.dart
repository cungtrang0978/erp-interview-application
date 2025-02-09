import 'package:injectable/injectable.dart';

import '../../../../core/models/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_datasource.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl(this.productDataSource);

  @override
  Future<List<Product>> getProducts() async {
    return productDataSource.getProducts();
  }
}
