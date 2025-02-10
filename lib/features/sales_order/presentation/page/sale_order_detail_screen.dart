import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/models/sale_order_item.dart';
import 'package:flutter_interview_application/dependency_injection/dependency_injection.dart';
import 'package:flutter_interview_application/features/sales_order/presentation/controllers/sale_order_detail_cubit.dart';

import '../../../../../core/models/sale_order.dart';

class SaleOrderDetailScreen extends StatefulWidget {
  final SaleOrder saleOrder;

  const SaleOrderDetailScreen({super.key, required this.saleOrder});

  @override
  State<SaleOrderDetailScreen> createState() => _SaleOrderDetailScreenState();
}

class _SaleOrderDetailScreenState extends State<SaleOrderDetailScreen> {
  final saleOrderDetailCubit = getIt<SaleOrderDetailCubit>();

  @override
  void initState() {
    saleOrderDetailCubit.fetchSaleOrderDetail(widget.saleOrder);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => saleOrderDetailCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text("Sale Order Details")),
        backgroundColor: Colors.grey.shade100,
        body: BlocBuilder<SaleOrderDetailCubit, SaleOrderDetailState>(
          builder: (context, state) {
            if (state is SaleOrderDetailLoaded) {
              final detail = state.saleOrder;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Order Summary"),
                    _buildInfoRow("Order ID", "#${detail.salesOrderId}"),
                    _buildInfoRow("Status", detail.status, textColor: _getStatusColor(detail.status)),
                    _buildInfoRow("Order Date", _formatDate(detail.orderDate)),
                    _buildInfoRow("Expected Delivery", _formatDate(detail.expectedDeliveryDate)),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Customer Details"),
                    _buildInfoRow("Customer ID", detail.customerId.toString()),
                    _buildInfoRow("Billing Address", detail.billingAddress),
                    _buildInfoRow("Shipping Address", detail.shippingAddress),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Financial Summary"),
                    _buildInfoRow("Total Amount", "\$${detail.totalAmount.toStringAsFixed(2)}", isBold: true),
                    _buildInfoRow("Tax Amount", "\$${detail.taxAmount.toStringAsFixed(2)}"),
                    _buildInfoRow("Shipping Fee", "\$${detail.shippingAmount.toStringAsFixed(2)}"),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Items"),
                    _buildItemList(detail.items),
                  ],
                ),
              );
            }

            if (state is SaleOrderDetailError) {
              return Center(child: Text("Failed to load sales orders"));
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  // Row for Order Details
  Widget _buildInfoRow(String label, String value, {bool isBold = false, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: textColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Placeholder for Order Items (Replace with real items later)
  Widget _buildItemList(List<SaleOrderItem> items) {
    return Column(
      children: items
          .map((item) => Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: const Icon(Icons.shopping_bag, color: Colors.blue),
                  title: Text(item.productName,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                  subtitle: Text(
                    "Qty: ${item.quantity}  |  Unit Price: \$${item.unitPrice}",
                    style: TextStyle(color: Colors.black87),
                  ),
                  trailing: Text("\$${item.quantity * item.unitPrice}",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                ),
              ))
          .toList(),
    );
  }

  // Get color based on order status
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

  // Format Date for Display
  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return "${date.month}/${date.day}/${date.year}";
  }
}
