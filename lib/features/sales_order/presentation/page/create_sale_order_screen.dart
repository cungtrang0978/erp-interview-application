import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/common_widgets/common_elevated_button.dart';
import 'package:flutter_interview_application/core/models/sale_order_item_draft.dart';
import 'package:flutter_interview_application/core/theme/app_color.dart';
import 'package:flutter_interview_application/dependency_injection/dependency_injection.dart';
import 'package:flutter_interview_application/features/sales_order/presentation/controllers/create_sale_order_cubit.dart';
import 'package:flutter_interview_application/features/sales_order/presentation/controllers/create_sale_order_info_cubit.dart';

import '../../../../core/common_widgets/amount_card.dart';
import '../../../../core/common_widgets/custom_text_field.dart';
import '../../../../core/common_widgets/order_item_list.dart';
import '../../../../core/models/customer.dart';
import '../../../../core/models/sale_order.dart';
import '../../../../core/models/sale_order_item.dart';
import 'add_item_screen.dart';

class CreateSaleOrderScreen extends StatefulWidget {
  const CreateSaleOrderScreen({super.key});

  @override
  State<CreateSaleOrderScreen> createState() => _CreateSaleOrderScreenState();
}

class _CreateSaleOrderScreenState extends State<CreateSaleOrderScreen> {
  final _infoCubit = getIt<CreateSaleOrderInfoCubit>();
  final _createCubit = getIt<CreateSaleOrderCubit>();
  final _formKey = GlobalKey<FormState>();

  final _shippingAddressController = TextEditingController();
  final _billingAddressController = TextEditingController();
  final _paymentTermsController = TextEditingController();
  final _subAmountController = TextEditingController();
  final _taxAmountController = TextEditingController();
  final _shippingAmountController = TextEditingController();
  final _totalAmountController = TextEditingController();
  final _notesController = TextEditingController();

  final List<SaleOrderItem> _items = [];
  Customer? _selectedCustomer;
  List<Customer> _customers = [];

  @override
  void initState() {
    super.initState();
    _infoCubit.fetchCustomers();
  }

  void _submitOrder(BuildContext context) {
    if (!_formKey.currentState!.validate() || _selectedCustomer == null) return;

    final saleOrder = SaleOrder(
      salesOrderId: 0,
      customerId: _selectedCustomer!.customerId,
      orderDate: DateTime.now(),
      expectedDeliveryDate: DateTime.now().add(const Duration(days: 5)),
      status: "CONFIRMED",
      shippingAddress: _shippingAddressController.text,
      billingAddress: _billingAddressController.text,
      paymentTerms: _paymentTermsController.text,
      currency: "USD",
      totalAmount: double.tryParse(_totalAmountController.text) ?? 0.0,
      taxAmount: double.tryParse(_taxAmountController.text) ?? 0.0,
      shippingAmount: double.tryParse(_shippingAmountController.text) ?? 0.0,
      notes: _notesController.text,
      items: _items,
    );

    _createCubit.createSaleOrder(saleOrder);
  }

  void _calculateAmounts() {
    double subAmount = _items.fold(0.0, (sum, item) => sum + (item.quantity * item.unitPrice));
    double taxAmount = double.tryParse(_taxAmountController.text) ?? 0.0;
    double shippingAmount = double.tryParse(_shippingAmountController.text) ?? 0.0;
    double totalAmount = subAmount + taxAmount + shippingAmount;

    setState(() {
      _subAmountController.text = subAmount.toStringAsFixed(2);
      _totalAmountController.text = totalAmount.toStringAsFixed(2);
    });
  }

  Future<void> _addItem(BuildContext context) async {
    final draft = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddItemScreen()),
    ) as SaleOrderItemDraft?;

    if (draft != null) {
      setState(() {
        _items.add(SaleOrderItem(
          salesOrderItemId: 0,
          salesOrderId: 0,
          productId: draft.product.productId,
          productName: draft.product.name,
          quantity: draft.quantity,
          unitPrice: draft.unitPrice,
          discountPercentage: draft.discountPercentage,
          taxPercentage: draft.taxPercentage,
          warehouseId: draft.warehouse.warehouseId,
          status: "PENDING",
        ));
        _calculateAmounts(); // ✅ Recalculate when a new item is added
      });
    }
  }

  void _onCustomerSelected(Customer? customer) {
    setState(() {
      _selectedCustomer = customer;
      _shippingAddressController.text = customer?.shippingAddress ?? "";
      _billingAddressController.text = customer?.billingAddress ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _infoCubit,
        ),
        BlocProvider(
          create: (context) => _createCubit,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Create Sale Order")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BlocBuilder<CreateSaleOrderInfoCubit, CreateSaleOrderInfoState>(
                  builder: (context, state) {
                    if (state is CreateSaleOrderInfoLoaded) {
                      _customers = state.customers;
                    }
                    return DropdownButtonFormField<Customer>(
                      value: _selectedCustomer,
                      items: _customers.map((customer) {
                        return DropdownMenuItem<Customer>(
                          value: customer,
                          child: Text(customer.name),
                        );
                      }).toList(),
                      onChanged: _onCustomerSelected,
                      decoration: const InputDecoration(labelText: "Select Customer"),
                      validator: (value) => value == null ? "Please select a customer" : null,
                    );
                  },
                ),
                const SizedBox(height: 8),
                CustomTextField(label: "Shipping Address", controller: _shippingAddressController),
                const SizedBox(height: 8),
                CustomTextField(label: "Billing Address", controller: _billingAddressController),
                const SizedBox(height: 8),
                CustomTextField(label: "Payment Terms", controller: _paymentTermsController),
                const SizedBox(height: 8),
                CustomTextField(
                  label: "Tax Amount (USD)",
                  controller: _taxAmountController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _calculateAmounts(),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: "Shipping Amount (USD)",
                  controller: _shippingAmountController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _calculateAmounts(),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: CommonElevatedButton(
                    height: 40,
                    onPressed: () => _addItem(context),
                    child: const Text("Add Item +"),
                  ),
                ),
                const SizedBox(height: 12),
                OrderItemList(
                  items: _items,
                  onRemove: (index) {
                    setState(() {
                      _items.removeAt(index);
                      _calculateAmounts(); // ✅ Recalculate when an item is removed
                    });
                  },
                ),
                const SizedBox(height: 20),
                AmountCard(label: "Sub Amount", value: _subAmountController.text),
                AmountCard(label: "Total Amount", value: _totalAmountController.text, color: AppColor.blue),
                const SizedBox(height: 20),
                BlocConsumer<CreateSaleOrderCubit, CreateSaleOrderState>(
                  listener: (context, state) {
                    if (state is CreateSaleOrderSuccess) {
                      Navigator.of(context).pop(true);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Sale order created successfully.")));
                    } else if (state is CreateSaleOrderFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: CommonElevatedButton(
                            onPressed: () => _submitOrder(context), child: const Text("Submit Order")),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
