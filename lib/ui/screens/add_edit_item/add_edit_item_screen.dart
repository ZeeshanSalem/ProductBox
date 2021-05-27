import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/models/response/items.dart';
import 'package:f2_base_project/ui/custom_widgets/input_text_field.dart';
import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEditItemScreen extends StatefulWidget {
  final Item? item;
  final bool isEdit;
  AddEditItemScreen({this.item, this.isEdit = false});

  @override
  _AddEditItemScreenState createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController? name;
  TextEditingController? price;

  @override
  void initState() {
    name = TextEditingController(text: widget?.item?.name);
    price = TextEditingController(text: widget?.item?.price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,

          appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
              onPressed: (){
                Navigator.of(context);
              },
            ),
            title: Text("Add Or Edit Item"),
          ),

          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [


                  InputTextField(
                    textController: name,
                    onValidation: (val){
                      if (val == null || val.length < 1) {
                        return 'Please enter item name';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val){
                      setState(() {
                        widget.item!.name = val.trim();
                      });
                    },
                    labelText: "Name",
                    hintText: "Enter NAME",
                  ),

                  SizedBox(height: 10.h,),

                  InputTextField(
                    textController: name,
                    onValidation: (val){
                      if (val == null || val.length < 1) {
                        return 'Please enter item price';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val){
                      setState(() {
                        widget.item!.name = val.trim();
                      });
                    },
                    labelText: "Price",
                    hintText: "Enter item price",
                  ),

                  SizedBox(height: 60.h,),

                  ///
                  /// Save OR Update Item Button
                  ///
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(top: 38, bottom: 20),
                    child: RectangularButton(
                      buttonColor: primaryColor,
                      text: "${widget.isEdit ?"UPDATE" : "SAVE"} ADDRESS",
                      textColor: Colors.black,
                      onPressed: (){
                        if(_formKey!.currentState!.validate()){
                          Navigator.pop(context, widget.item);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),);
  }
}
