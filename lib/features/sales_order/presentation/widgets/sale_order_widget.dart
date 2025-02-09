import 'package:flutter/material.dart';

import '../../../../core/models/sale_order.dart';

class SaleOrderWidget extends StatelessWidget {
  final SaleOrder order;
  final VoidCallback? onTap;

  const SaleOrderWidget({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Rounded Card
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10), // Clip splash effect
        child: InkWell(
          borderRadius: BorderRadius.circular(10), // Ensure rounded ripple
          onTap: onTap,
          splashColor: Colors.black12, // Softer ripple effect
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                // Status Icon with Rounded Splash Effect
                Material(
                  shape: const CircleBorder(),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50), // Rounded ripple
                    onTap: onTap,
                    splashColor: Colors.black26, // Softer splash color
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: _getStatusColor(order.status),
                      child: const Icon(Icons.shopping_cart, color: Colors.white, size: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Order Details (Compact)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${order.salesOrderId}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text("Customer: ID ${order.customerId}",
                          style: const TextStyle(fontSize: 12, color: Colors.black54)),
                      Text(
                        "${_formatDate(order.orderDate)} → ${_formatDate(order.expectedDeliveryDate)}",
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                // Total Price & Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${order.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(order.status, style: _getStatusTextStyle(order.status)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Softer Status Colors
  Color _getStatusColor(String status) {
    switch (status) {
      case "CONFIRMED":
        return Colors.blue.shade300;
      case "SHIPPED":
        return Colors.green.shade300;
      case "DELIVERED":
        return Colors.purple.shade300;
      case "PROCESSING":
        return Colors.orange.shade300;
      case "CANCELLED":
        return Colors.red.shade300;
      default:
        return Colors.grey.shade400;
    }
  }

  // Status Text Style
  TextStyle _getStatusTextStyle(String status) {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: _getStatusColor(status));
  }

  // Short Date Format
  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return "${date.month}/${date.day}/${date.year % 100}";
  }
}
