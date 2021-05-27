import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/ui/custom_widgets/image_container.dart';
import 'package:f2_base_project/ui/screens/cart/cart_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
        builder: (context, model, child) =>
            SafeArea(
                child: Scaffold(
                  backgroundColor: backgroundColor,

                  body: model.carts.length < 1 ?
                  Center(child: Text("Sorry, No item find in cart",
                  textAlign: TextAlign.center,
                  style: itemTextStyle.copyWith(
                    color: Colors.red),),
                    ): model.state == ViewState.busy ? Center(child: CircularProgressIndicator(),)
                      : ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                      itemBuilder: (context, index) => _cartTile(model, index),
                      separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                      itemCount: model.carts.length)
                ),),
    );
  }


  Widget _cartTile(CartViewModel model, int index){
    return Container(
//      height: 200.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: greyColor.withOpacity(0.2),
              offset: Offset(0.0, 1.0),
              blurRadius: 2.0,
            ),
            BoxShadow(
              color: greyColor.withOpacity(0.1),
              offset: Offset(1.0, 0.0),
              blurRadius: 1.0,
            ),
            BoxShadow(
              color: greyColor.withOpacity(0.1),
              offset: Offset(-1.0, 0.0),
              blurRadius: 1.0,
            ),
            BoxShadow(
              color: greyColor.withOpacity(0.1),
              offset: Offset(0.0, -1.0),
              blurRadius: 1.0,
            ),
          ]
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Image of Item
          ImageContainer(
              width: 150.w,
              height: 250.h,
              radius: 8.r,
              url: "${model.carts[index].img}",
            fit: BoxFit.cover,
          ),


          SizedBox(
            width: 10.w,
          ),

          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                      ///
                      /// Cancel Icon Button
                      ///
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            icon: Icon(Icons.cancel, size: 30.h, color: primaryColor,),
                            onPressed: (){
                              model.deleteCart(index);
                            }),
                      ),

                  Text(
                    "Items Id : ${model.carts[index].id}",
                    style: itemTextStyle,
                  ),

                  Text(
                    "Items Name : ${model.carts[index].name}",
                    style: itemTextStyle,
                  ),

                  Text(
                    "Items Price : ${model.carts[index].price}",
                    style: itemTextStyle,
                  ),



                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
