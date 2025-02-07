class PurchaseOrder {
  final int purchaseOrderId;
  final int supplierId;
  final DateTime orderDate;
  final DateTime? expectedDeliveryDate;
  final String status;
  final String deliveryAddress;
  final String? paymentTerms;
  final String? currency;
  final double totalAmount;
  final double taxAmount;
  final double shippingAmount;
  final String? notes;

  const PurchaseOrder({
    required this.purchaseOrderId,
    required this.supplierId,
    required this.orderDate,
    this.expectedDeliveryDate,
    required this.status,
    required this.deliveryAddress,
    this.paymentTerms,
    this.currency,
    required this.totalAmount,
    required this.taxAmount,
    required this.shippingAmount,
    this.notes,
  });

  // Convert JSON to PurchaseOrder Object
  factory PurchaseOrder.fromJson(Map<String, dynamic> json) {
    return PurchaseOrder(
      purchaseOrderId: int.tryParse(json['purchase_order_id'] ?? '') ?? 0,
      supplierId: int.tryParse(json['supplier_id'] ?? '') ?? 0,
      orderDate: DateTime.tryParse(json['order_date'] ?? '') ?? DateTime.now(),
      expectedDeliveryDate:
          json['expected_delivery_date'] != null ? DateTime.tryParse(json['expected_delivery_date'] ?? '') : null,
      status: json['status'] ?? '',
      deliveryAddress: json['delivery_address'] ?? '',
      paymentTerms: json['payment_terms'],
      currency: json['currency'],
      totalAmount: double.tryParse(json['total_amount'] ?? '') ?? 0.0,
      taxAmount: double.tryParse(json['tax_amount'] ?? '') ?? 0.0,
      shippingAmount: double.tryParse(json['shipping_amount'] ?? '') ?? 0.0,
      notes: json['notes'],
    );
  }

  // CopyWith Method to create a modified copy of the object
  PurchaseOrder copyWith({
    int? purchaseOrderId,
    int? supplierId,
    DateTime? orderDate,
    DateTime? expectedDeliveryDate,
    String? status,
    String? deliveryAddress,
    String? paymentTerms,
    String? currency,
    double? totalAmount,
    double? taxAmount,
    double? shippingAmount,
    String? notes,
  }) {
    return PurchaseOrder(
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      supplierId: supplierId ?? this.supplierId,
      orderDate: orderDate ?? this.orderDate,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      currency: currency ?? this.currency,
      totalAmount: totalAmount ?? this.totalAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      shippingAmount: shippingAmount ?? this.shippingAmount,
      notes: notes ?? this.notes,
    );
  }

  // Convert Object to String for Debugging
  @override
  String toString() {
    return 'PurchaseOrder(purchaseOrderId: $purchaseOrderId, supplierId: $supplierId, '
        'orderDate: $orderDate, expectedDeliveryDate: $expectedDeliveryDate, status: $status, '
        'deliveryAddress: $deliveryAddress, paymentTerms: $paymentTerms, currency: $currency, '
        'totalAmount: $totalAmount, taxAmount: $taxAmount, shippingAmount: $shippingAmount, notes: $notes)';
  }
}
