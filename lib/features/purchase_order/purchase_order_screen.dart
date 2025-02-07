import 'package:flutter/material.dart';

class PurchaseOrderScreen extends StatelessWidget {
  const PurchaseOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Purchase Order")),
      body: Center(child: Text("Purchase Order Content")),
    );
  }
}
