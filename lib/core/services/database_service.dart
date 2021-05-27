import 'package:dio/dio.dart';
import 'package:f2_base_project/core/constants/api_end_points.dart';
import 'package:f2_base_project/core/models/body/login_body.dart';
import 'package:f2_base_project/core/models/body/signup_body.dart';
import 'package:f2_base_project/core/models/cart.dart';
import 'package:f2_base_project/core/models/exceptions/response_exception.dart';
import 'package:f2_base_project/core/models/response/items.dart';
import 'package:f2_base_project/core/models/response/signup_response.dart';
import 'package:f2_base_project/core/models/response/user_profile_response.dart';
import '../constants/api_end_points.dart';
import '../constants/api_end_points.dart';
import 'api_services.dart';
import 'package:hive/hive.dart';

class DatabaseService {
//  Future<UserProfileResponse> getUserProfile() async {
//    late UserProfileResponse userProfileResponse;
//    Dio dio = ApiServices().launch();
//
//    final response =
//        await dio.get('${EndPoints.baseUrl}${EndPoints.userProfile}');
//
//    ///
//    /// Status code = 200 means the request was successfull and return the data
//    /// otherwise throw an exception which must be caught at the other end
//    /// from where this class method is triggered
//    ///
//    if (response.statusCode == 200) {
//      userProfileResponse = UserProfileResponse.fromJson(response.data);
//      return userProfileResponse;
//    } else {
//      throw ResponseException('Network request failed');
//    }
//  }
//
//  Future<AuthResponse> createUserAccount(SignUpBody body) async {
//    late AuthResponse authResponse;
//    Dio dio = ApiServices().launch();
//
//    final response = await dio.post(
//        '${EndPoints.baseUrl}${EndPoints.createAccount}',
//        data: body.toJson());
//
//    ///
//    /// Status code = 200 means the request was successfull and return the data
//    /// otherwise throw an exception which must be caught at the other end
//    /// from where this class method is triggered
//    ///
//    if (response.statusCode == 200) {
//      authResponse = AuthResponse.fromJson(response.data);
//      return authResponse;
//    } else {
//      throw ResponseException('Network request failed');
//    }
//  }
//
//  Future<AuthResponse> loginWithEmailAndPassword(LoginBody body) async {
//    late AuthResponse authResponse;
//    Dio dio = ApiServices().launch();
//
//    final response = await dio.post(
//        '${EndPoints.baseUrl}${EndPoints.createAccount}',
//        data: body.toJson());
//
//    ///
//    /// Status code = 200 means the request was successfull and return the data
//    /// otherwise throw an exception which must be caught at the other end
//    /// from where this class method is triggered
//    ///
//    if (response.statusCode == 200) {
//      authResponse = AuthResponse.fromJson(response.data);
//      return authResponse;
//    } else {
//      throw ResponseException('Network request failed');
//    }
//  }

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
