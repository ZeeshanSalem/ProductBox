import 'package:f2_base_project/core/models/response/items.dart';

class ItemResponse {
  List<Item?>? listOfItems;

  ItemResponse({this.listOfItems});

  ItemResponse.fromJson(Map<String, dynamic> json) {
    if (json['listOfItems'] != null) {
      listOfItems =[];
      json['listOfItems'].forEach((v) {
        listOfItems!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listOfItems != null) {
      data['listOfItems'] = this.listOfItems!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}