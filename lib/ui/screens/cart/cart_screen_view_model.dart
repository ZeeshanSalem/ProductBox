import 'package:f2_base_project/core/constants/api_end_points.dart';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/cart.dart';
import 'package:f2_base_project/core/models/response/items.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CartViewModel extends BaseViewModel{
  final _dbService = DatabaseService();
  
  List<Cart> carts = [];
  List<Item> item = [];
  int totalItemsInCart = 0;

  CartViewModel(){
    getAllCartItems();
  }
  
  getAllCartItems() async{
    setState(ViewState.busy);
    try{
      carts = (await _dbService.getAllCart())!;
      if(carts.isNotEmpty){
        for(int i = 0; i < carts.length; i++){
          print(carts[i].price);
        }
        totalItemsInCart = carts.length;
      }
    }catch(e,s){
      print("CartViewModel getAllCartItems() Exception $e");
      print(s);
    }
    setState(ViewState.idle);
  }
  
  addItemToCart(Item item) async{
    setState(ViewState.busy);
    try{
      var cart = Cart()
        ..id = item.id!
        ..price = item.price!
        ..name = item.name!
//        ..img = item.img!;
        ..img = "${EndPoints.imgUrl}/${item.img!.split('/').last}";

      await _dbService.addCart(cart);
      carts.add(cart);
      Get.snackbar("Success",
          "You have Successfully Add item to cart.",
          colorText: Colors.black,
          backgroundColor: primaryColor,
          duration: Duration(seconds: 1));
    }catch(e,s){
      print("CartViewModel addItemToCart() Exception $e");
      print(s);
    }
    setState(ViewState.idle);
  }

  ///
  /// Delete Cart Item
  ///
  deleteCart(index) async{
    setState(ViewState.busy);
    try{

      await _dbService.deleteCart(index);
      if(totalItemsInCart > 0) {
        totalItemsInCart--;
      }
      carts.removeAt(index);
      Get.snackbar("Success",
          "You have Successfully Delete item from cart.",
          colorText: Colors.black,
          backgroundColor: primaryColor,
          duration: Duration(seconds: 1));
    }catch(e,s){
      print("CartViewModel deleteCart() Exception $e");
      print(s);
    }
    setState(ViewState.idle);
  }
  
  
}