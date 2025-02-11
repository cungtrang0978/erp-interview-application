import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/dependency_injection/dependency_injection.dart';
import 'package:flutter_interview_application/features/purchase_order/presentation/controllers/purchase_order_cubit.dart';
import 'package:intl/intl.dart';

import 'purchase_order_detail_screen.dart';

class PurchaseOrderScreen extends StatefulWidget {
  const PurchaseOrderScreen({super.key});

  @override
  State<PurchaseOrderScreen> createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  final _purchaseOrderCubit = getIt<PurchaseOrderCubit>();

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  Color _getStatusColor(String status) {
    switch (status) {
      case 'CONFIRMED':
        return Colors.blue.shade300;
      case 'RECEIVED':
        return Colors.green.shade300;
      case 'CANCELLED':
        return Colors.red.shade300;
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    _purchaseOrderCubit.fetchPurchaseOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _purchaseOrderCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text("Purchase Orders")),
        body: BlocBuilder<PurchaseOrderCubit, PurchaseOrderState>(
          builder: (context, state) {
            if (state is PurchaseOrderLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PurchaseOrderError) {
              return Center(child: Text(state.message));
            } else if (state is PurchaseOrderLoaded) {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(order.status),
                      child: const Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                    ),
                    title: Text(
                      "PO #${order.purchaseOrderId} - ${order.currency ?? 'USD'}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${_formatDate(order.orderDate)} | Supplier: ${order.supplierId} | Total: \$${order.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PurchaseOrderDetailScreen(order: order),
                        ),
                      );
                    },
                  );
                },
              );
            }
            return const Center(child: Text("No purchase orders found"));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const CreatePurchaseOrderScreen()),
            // );
          },
          // label: const Text("New Order"),
          // backgroundColor: Colors.blue.shade300,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
