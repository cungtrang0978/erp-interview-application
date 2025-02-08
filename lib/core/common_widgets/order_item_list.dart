import 'package:flutter/material.dart';

import '../models/sale_order_item.dart';

class OrderItemList extends StatelessWidget {
  final List<SaleOrderItem> items;
  final Function(int) onRemove;

  const OrderItemList({super.key, required this.items, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const Text("No items added yet.", style: TextStyle(color: Colors.grey))
        : Column(
            children: [
              for (int i = 0; i < items.length; i++)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white, // Different from AmountCard
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(items[i].productName,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("Qty: ${items[i].quantity}", style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Unit Price", style: TextStyle(fontSize: 12, color: Colors.grey)),
                            Text("\$${items[i].unitPrice.toStringAsFixed(2)}"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("Total", style: TextStyle(fontSize: 12, color: Colors.grey)),
                            Text("\$${(items[i].quantity * items[i].unitPrice).toStringAsFixed(2)}",
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => onRemove(i),
                        icon: const Icon(Icons.close, color: Colors.red),
                      ),
                    ],
                  ),
                ),
            ],
          );
  }
}
