import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/response/items.dart';

import '../../../core/others/base_view_model.dart';
import '../../../core/services/database_service.dart';
import '../../../locator.dart';

class ItemListViewModel extends BaseViewModel{
  final _dbService = locator<DatabaseService>();
  List<Item> items = [];
  ItemListViewModel(){
    getAllItems();
  }

  getAllItems() async{
    setState(ViewState.idle);
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
}