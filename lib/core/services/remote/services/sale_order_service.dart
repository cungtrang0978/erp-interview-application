import 'package:injectable/injectable.dart';

import '../../../models/sale_order.dart';
import '../../../models/sale_order_item.dart';
import '../remote_database_service.dart';

@LazySingleton()
class SaleOrderService {
  Future<List<SaleOrder>> getSalesOrders() async {
    if (RemoteDatabaseService.conn == null) throw Exception("Database not initialized!");

    var result = await RemoteDatabaseService.conn!.execute("SELECT * FROM sales_orders ORDER BY order_date DESC");
    return result.rows.map((row) => SaleOrder.fromJson(row.assoc())).toList();
  }

  Future<SaleOrder?> getSaleOrderById(int salesOrderId) async {
    if (RemoteDatabaseService.conn == null) {
      throw Exception("Database RemoteDatabaseService.connection not initialized!");
    }

    var orderResult = await RemoteDatabaseService.conn!.execute(
      "SELECT * FROM sales_orders WHERE sales_order_id = :sales_order_id",
      {"sales_order_id": salesOrderId.toString()},
    );

    if (orderResult.numOfRows == 0) return null;

    return SaleOrder.fromJson(orderResult.rows.first.assoc());
  }

  Future<List<SaleOrderItem>> getSalesOrderItems(int salesOrderId) async {
    if (RemoteDatabaseService.conn == null) {
      throw Exception("Database RemoteDatabaseService.connection not initialized!");
    }

    var itemsResult = await RemoteDatabaseService.conn!.execute(
      """
      SELECT soi.*, p.name AS product_name
      FROM sales_order_items soi
      JOIN products p ON soi.product_id = p.product_id
      WHERE soi.sales_order_id = :sales_order_id
      """,
      {"sales_order_id": salesOrderId.toString()},
    );

    return itemsResult.rows.map((row) => SaleOrderItem.fromJson(row.assoc())).toList();
  }

  /// **1️⃣ Insert Sale Order and Return Order ID**
  Future<int> insertSaleOrder(SaleOrder saleOrder) async {
    var result = await RemoteDatabaseService.conn!.execute(
      """
      INSERT INTO sales_orders (customer_id, order_date, expected_delivery_date, status, 
        shipping_address, billing_address, payment_terms, currency, total_amount, tax_amount, 
        shipping_amount, notes) 
      VALUES (:customer_id, :order_date, :expected_delivery_date, :status, :shipping_address, 
        :billing_address, :payment_terms, :currency, :total_amount, :tax_amount, :shipping_amount, :notes)
      """,
      {
        "customer_id": saleOrder.customerId.toString(),
        "order_date": saleOrder.orderDate.toIso8601String(),
        "expected_delivery_date": saleOrder.expectedDeliveryDate?.toIso8601String() ?? "",
        "status": saleOrder.status,
        "shipping_address": saleOrder.shippingAddress,
        "billing_address": saleOrder.billingAddress,
        "payment_terms": saleOrder.paymentTerms ?? "",
        "currency": saleOrder.currency ?? "USD",
        "total_amount": saleOrder.totalAmount.toString(),
        "tax_amount": saleOrder.taxAmount.toString(),
        "shipping_amount": saleOrder.shippingAmount.toString(),
        "notes": saleOrder.notes ?? "",
      },
    );

    return result.lastInsertID.toInt();
  }

  /// **2️⃣ Insert Sale Order Item**
  Future<void> insertSaleOrderItem(int orderId, SaleOrderItem item) async {
    await RemoteDatabaseService.conn!.execute(
      """
      INSERT INTO sales_order_items (sales_order_id, product_id, quantity, unit_price, discount_percentage, 
        tax_percentage, warehouse_id, status) 
      VALUES (:sales_order_id, :product_id, :quantity, :unit_price, :discount_percentage, :tax_percentage, 
        :warehouse_id, :status)
      """,
      {
        "sales_order_id": orderId.toString(),
        "product_id": item.productId.toString(),
        "quantity": item.quantity.toString(),
        "unit_price": item.unitPrice.toString(),
        "discount_percentage": item.discountPercentage.toString(),
        "tax_percentage": item.taxPercentage.toString(),
        "warehouse_id": item.warehouseId.toString(),
        "status": "PENDING",
      },
    );
  }
}
