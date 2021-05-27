import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/cart.dart';
import 'package:f2_base_project/core/models/response/items.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/database_service.dart';

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
        carts.forEach((element) {
          totalItemsInCart = element.totalItemInCart ?? 0;
              print(element.item.toJson());});
      }
    }catch(e,s){
      print("CartViewModel getAllCartItems() Exception $e");
      print(s);
    }
    setState(ViewState.idle);
  }
  
  addItemToCart(Cart cart) async{
    setState(ViewState.busy);
    try{
      cart.totalItemInCart =  totalItemsInCart + 1;
      await _dbService.addCart(cart);
    }catch(e,s){
      print("CartViewModel addItemToCart() Exception $e");
      print(s);
    }
    setState(ViewState.busy);
  }
  
  
}