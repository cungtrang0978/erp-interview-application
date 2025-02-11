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
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens(BuildContext context) {
    return [
      const SaleOrderScreen(),
      const PurchaseOrderScreen(),
      const InventoryScreen(),
      SettingsScreen(parentContext: context),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _buildNavItem(
        icon: Icons.shopping_cart_outlined,
        activeIcon: Icons.shopping_cart,
        title: "Sales",
      ),
      _buildNavItem(
        icon: Icons.receipt_long_outlined,
        activeIcon: Icons.receipt_long,
        title: "Purchase",
      ),
      _buildNavItem(
        icon: Icons.inventory_2_outlined,
        activeIcon: Icons.inventory_2,
        title: "Inventory",
      ),
      _buildNavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        title: "Settings",
      ),
    ];
  }

  PersistentBottomNavBarItem _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String title,
  }) {
    return PersistentBottomNavBarItem(
      icon: Icon(
        icon,
        size: 22,
      ),
      title: title,
      activeColorPrimary: AppColor.blue,
      inactiveColorPrimary: Colors.grey.shade400,
      iconSize: 22,
      textStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(context),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style1,
        // Modern floating style
        backgroundColor: Colors.white,
        // decoration: NavBarDecoration(
        //   borderRadius: BorderRadius.circular(20),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black.withAlpha(20),
        //       blurRadius: 10,
        //       offset: const Offset(0, -2),
        //     ),
        //   ],
        // ),
        navBarHeight: 65,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        hideNavigationBarWhenKeyboardAppears: true,
        animationSettings: NavBarAnimationSettings(
          // screenTransitionAnimation: ScreenTransitionAnimationSettings(
          //   animateTabTransition: true,
          //   curve: Curves.easeInOut,
          //   duration: Duration(milliseconds: 200),
          // ),
          navBarItemAnimation: ItemAnimationSettings(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          ),
        ),
        // floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
