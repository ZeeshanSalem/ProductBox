import 'package:f2_base_project/core/constants/api_end_points.dart';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/items.dart';
import 'package:f2_base_project/ui/custom_widgets/image_container.dart';
import 'package:f2_base_project/ui/screens/add_edit_item/add_edit_item_screen.dart';
import 'package:f2_base_project/ui/screens/cart/cart_screen_view_model.dart';
import 'package:f2_base_project/ui/screens/items/items_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
      create: (context) => ItemListViewModel(),
      child: Consumer<ItemListViewModel>(
        builder: (context, model, child) => SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            body: model.state == ViewState.busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    itemBuilder: (context, index) => _itemTile(model, index, context),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                    itemCount: model.items.length),

            /// Floating button For move to Add Shipping Address Screen
            ///
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Item item = await Get.to(AddEditItemScreen(
                  item: Item(),
                ));
                if (item != null) {
                  print(item.name);
                  model.addItem(item);
                }
              },
              splashColor: Colors.black12,
              backgroundColor: primaryColor,
              child: Icon(
                Icons.add,
                size: 35.h,
                color: Colors.black,
              ),
              tooltip: "Add Shipping Address",
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemTile(ItemListViewModel model, int index, BuildContext context) {
    final cardViewModel = Provider.of<CartViewModel>(context);
    return InkWell(
      onTap: () async {
//        Item item = await Get.to(AddEditItemScreen(
//          item: Item(
//            name: model.items[index].name,
//            price: model.items[index].price,
//
//          ),
//        ));
//        if (item != null) {
//          print(item.name);
//          model.updateItem(item);
//        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: greyColor.withOpacity(0.3),
                offset: Offset(0.1, 1.0),
                spreadRadius: 0.5,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            /// Main Purpose of this check  img api endpints
            /// because there is problem in post api
            ///
            model.items[index].img == null
                ? ImageContainer(
                    width: double.infinity,
                    height: 200.h,
                    assets: "assets/static_assets/loading.png",
                  )
                :
            ImageContainer(
                    width: double.infinity,
                    height: 200.h,
                    radius: 15.r,
                    url:
                        "${EndPoints.imgUrl}${model.items[index].img!.split("/").last}",
                  ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Items Id : ${model.items[index].id!}",
                style: itemTextStyle,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Items Name : ${model.items[index].name ?? ""}",
                style: itemTextStyle,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Items Price : ${model.items[index].price ?? ""}",
                style: itemTextStyle,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        cardViewModel.addItemToCart(model.items[index]);
                      },
                      child: Text(
                        "Add to Cart",
                        style: itemTextStyle.copyWith(color: Colors.green),
                      )),
                  TextButton(
                      onPressed: () {
                        model.deleteItem(model.items[index]);
                      },
                      child: Text(
                        "Delete",
                        style: itemTextStyle.copyWith(color: Colors.red),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
