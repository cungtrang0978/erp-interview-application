import 'sale_order_item.dart';

class SaleOrder {
  final int salesOrderId;
  final int customerId;
  final DateTime orderDate;
  final DateTime? expectedDeliveryDate;
  final String status;
  final String shippingAddress;
  final String billingAddress;
  final String? paymentTerms;
  final String? currency;
  final double totalAmount;
  final double taxAmount;
  final double shippingAmount;
  final String? notes;
  final List<SaleOrderItem> items;

  const SaleOrder({
    required this.salesOrderId,
    required this.customerId,
    required this.orderDate,
    this.expectedDeliveryDate,
    required this.status,
    required this.shippingAddress,
    required this.billingAddress,
    this.paymentTerms,
    this.currency,
    required this.totalAmount,
    required this.taxAmount,
    required this.shippingAmount,
    this.notes,
    this.items = const [],
  });

  // Convert JSON to SaleOrder Object
  factory SaleOrder.fromJson(Map<String, dynamic> json) {
    return SaleOrder(
      salesOrderId: int.tryParse(json['sales_order_id'] ?? '') ?? 0,
      customerId: int.tryParse(json['customer_id'] ?? '') ?? 0,
      orderDate: DateTime.tryParse(json['order_date'] ?? '') ?? DateTime.now(),
      expectedDeliveryDate:
          json['expected_delivery_date'] != null ? DateTime.tryParse(json['expected_delivery_date'] ?? '') : null,
      status: json['status'] ?? '',
      shippingAddress: json['shipping_address'] ?? '',
      billingAddress: json['billing_address'] ?? '',
      paymentTerms: json['payment_terms'],
      currency: json['currency'],
      totalAmount: double.tryParse(json['total_amount'] ?? '') ?? 0.0,
      taxAmount: double.tryParse(json['tax_amount'] ?? '') ?? 0.0,
      shippingAmount: double.tryParse(json['shipping_amount'] ?? '') ?? 0.0,
      notes: json['notes'],
      items: [], // Items will be added separately
    );
  }

  // CopyWith Method to add items
  SaleOrder copyWith({List<SaleOrderItem>? items}) {
    return SaleOrder(
      salesOrderId: salesOrderId,
      customerId: customerId,
      orderDate: orderDate,
      expectedDeliveryDate: expectedDeliveryDate,
      status: status,
      shippingAddress: shippingAddress,
      billingAddress: billingAddress,
      paymentTerms: paymentTerms,
      currency: currency,
      totalAmount: totalAmount,
      taxAmount: taxAmount,
      shippingAmount: shippingAmount,
      notes: notes,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return 'SaleOrder(salesOrderId: $salesOrderId, customerId: $customerId, items: ${items.length})';
  }
}
