import 'package:injectable/injectable.dart';

import '../../../../core/models/sale_order.dart';
import '../../domain/repositories/sale_order_repository.dart';
import '../datasources/sale_order_datasource.dart';

@LazySingleton(as: SaleOrderRepository)
class SaleOrderRepositoryImpl implements SaleOrderRepository {
  final SaleOrderDataSource saleOrderDataSource;

  SaleOrderRepositoryImpl(this.saleOrderDataSource);

  @override
  Future<List<SaleOrder>> fetchAllSaleOrders() async {
    return await saleOrderDataSource.getSaleOrders();
  }

  @override
  Future<SaleOrder?> fetchSaleOrderDetailById(int id) async {
    return await saleOrderDataSource.getSaleOrderDetailById(id);
  }

  @override
  Future<int> createSaleOrder(SaleOrder saleOrder) async {
    return await saleOrderDataSource.createSaleOrder(saleOrder);
  }

  @override
  Future<void> updateSaleOrder(SaleOrder saleOrder) async {
    return await saleOrderDataSource.updateSaleOrder(saleOrder);
  }

  @override
  Future<void> deleteSaleOrder(int id) async {
    return await saleOrderDataSource.deleteSaleOrder(id);
  }
}
