import 'package:f2_base_project/core/models/response/items.dart';
import 'package:hive/hive.dart';
part  'cart.g.dart';

@HiveType(typeId: 0)
class Cart extends HiveObject{
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String price;
  @HiveField(3)
  late String img;
}