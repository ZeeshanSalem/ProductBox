import 'package:f2_base_project/core/constants/api_end_points.dart';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/ui/custom_widgets/image_container.dart';
import 'package:f2_base_project/ui/screens/items/items_list_view_model.dart';
import 'package:flutter/material.dart';
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
                    itemBuilder: (context, index) => Container(
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
                                      assets:
                                          "assets/static_assets/loading.png",
                                    )
                                  : ImageContainer(
                                      width: double.infinity,
                                      height: 200.h,
                                      radius: 15.r,
                                      url:
                                          "${EndPoints.imgUrl}${model.items[index].img!.split("/").last}",
                                    ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  "Items Id : ${model.items[index].id}",
                                  style: itemTextStyle,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Items Name : ${model.items[index].name}",
                                  style: itemTextStyle,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  "Items Price : ${model.items[index].price}",
                                  style: itemTextStyle,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    TextButton(
                                        onPressed: (){},
                                        child: Text("Add to Cart",
                                        style: itemTextStyle.copyWith(color: Colors.green),)),

                                    TextButton(
                                        onPressed: (){
                                          model.deleteItem(model.items[index]);
                                        },
                                        child: Text("Delete",
                                          style: itemTextStyle.copyWith(color: Colors.red),)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),


                    separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                    itemCount: model.items.length),
          ),
        ),
      ),
    );
  }

}
