import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/dependency_injection/dependency_injection.dart';
import 'package:flutter_interview_application/features/sales_order/presentation/controllers/sale_order_list_cubit.dart';
import 'package:flutter_interview_application/features/sales_order/presentation/page/create_sale_order_screen.dart';

import '../widgets/sale_order_widget.dart';
import 'sale_order_detail_screen.dart';

class SaleOrderScreen extends StatefulWidget {
  const SaleOrderScreen({super.key});

  @override
  State<SaleOrderScreen> createState() => _SaleOrderScreenState();
}

class _SaleOrderScreenState extends State<SaleOrderScreen> {
  final _saleOrderListCubit = getIt<SaleOrderListCubit>();

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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final created = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateSaleOrderScreen(),
              ),
            ) as bool?;
            if (created != null && created) {
              _saleOrderListCubit.fetchSaleOrders();
            }
          },
          child: Icon(Icons.add),
        ),
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
