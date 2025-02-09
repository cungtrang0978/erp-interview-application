import '../../../../core/models/sale_order.dart';

abstract class SaleOrderRepository {
  Future<List<SaleOrder>> fetchAllSaleOrders();

  Future<SaleOrder?> fetchSaleOrderDetailById(int id);

  Future<int> createSaleOrder(SaleOrder saleOrder);

  Future<void> updateSaleOrder(SaleOrder saleOrder);

  Future<void> deleteSaleOrder(int id);
}
