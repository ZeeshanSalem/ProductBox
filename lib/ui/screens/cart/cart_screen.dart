import 'package:f2_base_project/ui/screens/cart/cart_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
        builder: (context, model, child) =>
            SafeArea(
                child: Scaffold(
                  body: Container(
                    color: Colors.red,
                  ),
                ),),
    );
  }
}
