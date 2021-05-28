import 'package:dio/dio.dart';
import 'package:f2_base_project/core/constants/api_end_points.dart';
import 'package:f2_base_project/core/models/cart.dart';
import 'package:f2_base_project/core/models/items.dart';
import '../constants/api_end_points.dart';
import 'api_services.dart';
import 'package:hive/hive.dart';

class DatabaseService {
  Future<List<Item>?> getItemFromDB() async{
    List<Item> items = [];
    try {
      Dio dio = ApiServices().launch();
      final Response response =
      await dio.get("${EndPoints.baseUrl}${EndPoints.items}");

      if(response.statusCode == 200){

        response.data.forEach((element) {
          items.add(Item.fromJson(element));
        });
      }

      return items;

    }catch(e,s){
      print( "GetItem Exception"+ e.toString());
      print(s);
    }
  }

  Future<bool?> deleteItem(id) async{
    bool isDeleted = false;
    try{
      Dio dio = ApiServices().launch();
      final Response response =
          await dio.delete("${EndPoints.baseUrl}${EndPoints.items}/$id");

      if(response.statusCode == 204){
        isDeleted = true;
      }

      return isDeleted;
    }catch(e,s){
      print( "delete Item Exception"+ e.toString());
      print(s);
    }
  }


  Future<bool?> addItem(Item item) async{
    bool isItemAdded = false;
    try{
      Dio dio = ApiServices().launch();
      FormData formData = FormData.fromMap(item.toJson());
      final Response response =
          await dio.post("${EndPoints.baseUrl}${EndPoints.items}/", data: formData);

      if(response.statusCode == 200){
        isItemAdded = true;
      }

      return isItemAdded;
    }catch(e,s){
      print( "Exception addItem"+ e.toString());
      print(s);
    }
  }

  Future<bool?> updateItem(Item item) async{
    bool isItemUpdated = false;
    try{
      Dio dio = ApiServices().launch();
      FormData formData = FormData.fromMap(item.toJson());
      final Response response =
      await dio.put("${EndPoints.baseUrl}${EndPoints.items}/${item.id}", data: formData);

      if(response.statusCode == 200){
        isItemUpdated = true;
      }

      return isItemUpdated;
    }catch(e,s){
      print( "Exception addItem"+ e.toString());
      print(s);
    }
  }

  ///
  /// ===============  Using Hive Local Mobile Database ================
  ///

  /// add Cart
  Future<void> addCart(Cart cart) async{
    try{
      var box = await Hive.openBox<Cart>('cart');
      box.add(cart);

    }catch(e,s){
      print( "Exception addToCart"+ e.toString());
      print(s);
    }
  }

  /// add Cart
  Future<void> deleteCart(index) async{
    try{
      var box = await Hive.openBox<Cart>('cart');
      box.deleteAt(index);
    }catch(e,s){
      print( "Exception deleteCart"+ e.toString());
      print(s);
    }
  }


  Future<List<Cart>?> getAllCart() async{
    List<Cart> carts = [];
    try{
      var box = await Hive.openBox<Cart>('cart');
      carts =  box.values.toList();
      return carts;
    }catch(e,s){
      print( "Exception addToCart"+ e.toString());
      print(s);
    }
  }





}
