import 'package:flutter/material.dart';
import 'package:flutter_interview_application/dependency_injection/dependency_injection.dart';
import 'package:flutter_interview_application/domain/repositories/inventory_repository.dart';
import 'package:flutter_interview_application/domain/repositories/product_repository.dart';
import 'package:flutter_interview_application/domain/repositories/warehouse_repository.dart';

import '../../../core/models/inventory.dart';
import '../../../core/models/product.dart';
import '../../../core/models/sale_order_item_draft.dart';
import '../../../core/models/warehouse.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  List<Product> _products = [];
  List<Warehouse> _warehouses = [];
  Inventory? _inventory;

  Product? _selectedProduct;
  Warehouse? _selectedWarehouse;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    _products = await getIt<ProductRepository>().getProducts();
    setState(() => _isLoading = false);
  }

  Future<void> _loadWarehouses() async {
    if (_selectedProduct == null) return;

    setState(() => _isLoading = true);

    var allWarehouses = await getIt<WarehouseRepository>().fetchAllWarehouses();
    List<Warehouse> filteredWarehouses = [];

    for (var warehouse in allWarehouses) {
      Inventory? inventory = await getIt<InventoryRepository>()
          .getInventoryByProductAndWarehouse(_selectedProduct!.productId, warehouse.warehouseId);
      if (inventory != null && inventory.quantityOnHand > inventory.quantityReserved) {
        filteredWarehouses.add(warehouse);
      }
    }

    setState(() {
      _warehouses = filteredWarehouses;
      _selectedWarehouse = null;
      _inventory = null;
      _isLoading = false;
    });
  }

  Future<void> _checkInventory() async {
    if (_selectedProduct == null || _selectedWarehouse == null) return;

    setState(() => _isLoading = true);

    _inventory = await getIt<InventoryRepository>().getInventoryByProductAndWarehouse(
      _selectedProduct!.productId,
      _selectedWarehouse!.warehouseId,
    );

    setState(() => _isLoading = false);
  }

  void _addItem() {
    if (!_formKey.currentState!.validate()) return;

    int quantity = int.tryParse(_quantityController.text) ?? 0;
    double unitPrice = double.tryParse(_unitPriceController.text) ?? 0.0;

    final draft = SaleOrderItemDraft(
      product: _selectedProduct!,
      warehouse: _selectedWarehouse!,
      quantity: quantity,
      unitPrice: unitPrice,
    );
    Navigator.pop(context, draft);
  }

  String? _validateQuantity(String? value) {
    if (value == null || value.isEmpty) return "Quantity is required";
    int? quantity = int.tryParse(value);
    if (quantity == null || quantity <= 0) return "Quantity must be greater than 0";
    if (_inventory != null && quantity > (_inventory!.quantityOnHand - _inventory!.quantityReserved)) {
      return "Not enough stock available";
    }
    return null;
  }

  String? _validateUnitPrice(String? value) {
    if (value == null || value.isEmpty) return "Unit Price is required";
    double? price = double.tryParse(value);
    if (price == null || price <= 0) return "Unit Price must be greater than 0";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<Product>(
                      value: _selectedProduct,
                      items: _products.map((product) {
                        return DropdownMenuItem<Product>(
                          value: product,
                          child: Text("${product.name} (${product.sku})"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedProduct = value;
                          _warehouses = [];
                          _selectedWarehouse = null;
                          _inventory = null;
                        });
                        _loadWarehouses();
                      },
                      decoration: const InputDecoration(labelText: "Select Product"),
                      validator: (value) => value == null ? "Please select a product" : null,
                    ),
                    DropdownButtonFormField<Warehouse>(
                      value: _selectedWarehouse,
                      items: _warehouses.map((warehouse) {
                        return DropdownMenuItem<Warehouse>(
                          value: warehouse,
                          child: Text(warehouse.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedWarehouse = value;
                        });
                        _checkInventory();
                      },
                      decoration: const InputDecoration(labelText: "Select Warehouse"),
                      validator: (value) => value == null ? "Please select a warehouse" : null,
                    ),
                    if (_inventory != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text("Available Stock: ${_inventory!.quantityOnHand - _inventory!.quantityReserved}",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      ),
                    TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(labelText: "Quantity"),
                      keyboardType: TextInputType.number,
                      validator: _validateQuantity,
                    ),
                    TextFormField(
                      controller: _unitPriceController,
                      decoration: const InputDecoration(labelText: "Unit Price", suffixText: "USD"),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: _validateUnitPrice,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: _addItem, child: const Text("Add Item")),
                  ],
                ),
              ),
            ),
    );
  }
}
