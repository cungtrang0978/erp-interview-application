import 'package:flutter/material.dart';
import 'package:flutter_interview_application/core/theme/app_color.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../inventory/presentation/page/inventory_screen.dart';
import '../purchase_order/presentation/page/purchase_order_screen.dart';
import '../sales_order/presentation/page/sale_order_screen.dart';
import '../settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens(BuildContext context) {
    return [
      SaleOrderScreen(),
      PurchaseOrderScreen(),
      InventoryScreen(),
      SettingsScreen(
        parentContext: context,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: "Sale Order",
        activeColorPrimary: AppColor.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.receipt),
        title: "Purchase Order",
        activeColorPrimary: AppColor.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.inventory),
        title: "Inventory",
        activeColorPrimary: AppColor.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: AppColor.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(context),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style3, // Change style if needed
    );
  }
}
