import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class InputTextField extends StatelessWidget {
  final labelText;
  final hintText;
  final onSaved;
  final onValidation;
  final bool obscure;
  final textController;
  final inputType;
  InputTextField({
    this.labelText,
    this.hintText,
    this.onValidation,
    this.onSaved,
    this.obscure = false,
    this.textController,
    this.inputType = TextInputType.emailAddress,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1), offset: Offset(1.0, 1.0)),
          ]),
      child: TextFormField(
        cursorColor: greyColor,
        validator: onValidation,
        controller: textController ?? TextEditingController(),
        obscureText: obscure,
        style: itemTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp),
        onSaved: onSaved,
        onChanged: onSaved,
        textInputAction: TextInputAction.next,
        keyboardType: inputType,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 5, bottom: 6),
//          contentPadding: EdgeInsets.only(top: 18.0),
            hintText: hintText,
            labelText: labelText,
            labelStyle: itemTextStyle.copyWith(
              fontSize: 14.sp,
              color: Colors.grey,
            )),
      ),
    );
  }
}
