import 'package:flutter/material.dart';

import '../../../../../core/models/purchase_order.dart';

class PurchaseOrderDetailScreen extends StatelessWidget {
  final PurchaseOrder order;
  const PurchaseOrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Purchase Order #${order.purchaseOrderId}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Supplier ID: ${order.supplierId}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Order Date: ${order.orderDate}"),
            Text("Expected Delivery: ${order.expectedDeliveryDate}"),
            Text("Status: ${order.status}"),
            Text("Total Amount: \$${order.totalAmount.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}
