import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/sale_order_list_cubit.dart';
import '../widgets/sale_order_widget.dart';
import 'sale_order_detail_screen.dart';

class SaleOrderScreen extends StatefulWidget {
  const SaleOrderScreen({super.key});

  @override
  State<SaleOrderScreen> createState() => _SaleOrderScreenState();
}

class _SaleOrderScreenState extends State<SaleOrderScreen> {
  final _saleOrderListCubit = SaleOrderListCubit();

  @override
  void initState() {
    _saleOrderListCubit.fetchSaleOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _saleOrderListCubit,
      child: Scaffold(
        appBar: AppBar(title: Text("Sales Orders")),
        body: BlocBuilder<SaleOrderListCubit, SaleOrderListState>(
          builder: (context, state) {
            if (state is SaleOrderListLoaded) {
              return ListView.builder(
                itemCount: state.saleOrders.length,
                itemBuilder: (context, index) {
                  var order = state.saleOrders[index];
                  return SaleOrderWidget(
                    order: order,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SaleOrderDetailScreen(saleOrder: order),
                        ),
                      );
                    },
                  );
                },
              );
            }

            if (state is SaleOrderListError) {
              return Center(child: Text("Failed to load sales orders"));
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
