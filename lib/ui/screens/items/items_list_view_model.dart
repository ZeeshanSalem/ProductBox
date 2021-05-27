import 'package:f2_base_project/core/constants/api_end_points.dart';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/response/items.dart';
import 'package:get/get.dart';
import '../../../core/others/base_view_model.dart';
import '../../../core/services/database_service.dart';
import '../../../locator.dart';
import 'package:flutter/material.dart';

class ItemListViewModel extends BaseViewModel{
  final _dbService = locator<DatabaseService>();
  List<Item> items = [];
  ItemListViewModel(){
    getAllItems();
  }

  getAllItems() async{
    setState(ViewState.busy);
    try{
   items =  (await _dbService.getItemFromDB())!;
   if(items.isNotEmpty){
     items.forEach((element) {
       print(element.toJson());
     });
   }
    }catch(e,s){
      print("@ItemsViewModel getItems Exception : $e");
      print(s);
    }
    setState(ViewState.idle);

  }

  /// Delete Item
  deleteItem(Item item) async{
    setState(ViewState.busy);
    try{
      bool isDeleted = (await _dbService.deleteItem(item.id))!;

      if(isDeleted){
        items.remove(item);
        Get.snackbar("Success",
            "You have Successfully deleted item No # ${item.id}",
            colorText: Colors.black,
            backgroundColor: primaryColor,
            duration: Duration(seconds: 1));
      } else{
        Get.snackbar("Failure",
            "Sorry, You can;t deleted item No # ${item.id}",
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 1));
      }
    }catch(e,s){
      print("@ItemsViewModel deleteItem Exception : $e");
      print(s);
    }
    setState(ViewState.idle);
  }

  addItem(Item item) async{
    setState(ViewState.busy);
    item.id = items.length + 1;
    item.img = "${EndPoints.imgUrl}bed.jpg";
    try{
      bool isAdded = (await _dbService.addItem(item))!;

      if(isAdded){
        items.add(item);
        Get.snackbar("Success",
            "You have Successfully Add item.",
            colorText: Colors.black,
            backgroundColor: primaryColor,
            duration: Duration(seconds: 1));
      } else{
        Get.snackbar("Failure",
            "Sorry, You can;t add item No",
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 1));
      }
    }catch(e,s){
      print("@ItemsViewModel deleteItem Exception : $e");
      print(s);
    }
    setState(ViewState.idle);
  }


  updateItem(Item item) async{
    setState(ViewState.busy);
//    item.id = items.length + 1;
//    item.img = "${EndPoints.imgUrl}bed.jpg";
    try{
      bool isUpdated = (await _dbService.updateItem(item))!;

      if(isUpdated){
        items.add(item);
        Get.snackbar("Success",
            "You have Successfully Update item No # ${item.id}.",
            colorText: Colors.black,
            backgroundColor: primaryColor,
            duration: Duration(seconds: 1));
      } else{
        Get.snackbar("Failure",
            "Sorry, You can;t update item No # ${item.id}",
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 1));
      }
    }catch(e,s){
      print("@ItemsViewModel deleteItem Exception : $e");
      print(s);
    }
    setState(ViewState.idle);
  }
  }