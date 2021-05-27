import 'package:f2_base_project/core/models/response/items.dart';
import 'package:hive/hive.dart';
part  'cart.g.dart';

@HiveType(typeId: 0)
class Cart extends HiveObject{
  @HiveField(0)
  late double totalAmount;
  @HiveField(1)
  late int totalItemInCart;
  @HiveField(2)
  late Item item;
}