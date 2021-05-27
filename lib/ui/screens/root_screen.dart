import 'package:badges/badges.dart';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/ui/screens/cart/cart_screen.dart';
import 'package:f2_base_project/ui/screens/cart/cart_screen_view_model.dart';
import 'package:f2_base_project/ui/screens/items/items_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  /// List of screen for bottom Navigation bar
  List<Widget> screenList = [
    ItemListScreen(),
//    ItemListScreen(),
    CartScreen(),
    ItemListScreen()
  ];

  /// By Default screen index
  int selectedScreen = 0;

  /// This method for to change Screen
  onChangeScreen(int value) {
    print("Selected Screen Index $value");
    setState(() {
      selectedScreen = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    return SafeArea(
      child: Scaffold(

        body: screenList.elementAt(selectedScreen),

        bottomNavigationBar: BottomAppBar(
          color: backgroundColor,
          elevation: 0.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 3, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                selectedIconTheme: IconThemeData(color: primaryColor, size: 30),
                unselectedIconTheme: IconThemeData(color: greyColor, size: 25),
                unselectedLabelStyle: itemTextStyle.copyWith(fontSize: 12,),
                selectedLabelStyle: itemTextStyle.copyWith(fontSize: 12, color: primaryColor),
                currentIndex: selectedScreen,
                unselectedItemColor: greyColor,
                selectedItemColor: primaryColor,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                onTap: (val) {
                  onChangeScreen(val);
                },
                items: [
                  bottomNavItem(
                      icon: selectedScreen == 0 ? Icons.home : Icons.home_outlined,
                      label: "Home"),
                  bottomNavItem(
                      count: cartViewModel.totalItemsInCart,
                      icon: selectedScreen == 1
                          ? Icons.shopping_bag
                          : Icons.shopping_bag_outlined,
                      label: "add item"),
                  bottomNavItem(
                      icon: selectedScreen == 2 ? Icons.person : Icons.person_outline,
                      label: "Profile"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// This method for bottom nav bar item
  ///
  bottomNavItem({IconData? icon, String? label, int? count}) {
    return BottomNavigationBarItem(
//      icon: Icon(icon!),
      icon:  Badge(
          animationType: BadgeAnimationType.fade,
          showBadge: count == null || count < 1 ? false : true,
          badgeColor: Colors.black,
          badgeContent: Text("${count ?? ""}", style: itemTextStyle.copyWith(fontSize: 12.sp, color: Colors.white),),
          child: Icon(icon)),
      label: label,
    );
  }
}
