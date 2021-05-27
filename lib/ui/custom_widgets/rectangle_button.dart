import 'package:f2_base_project/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RectangularButton extends StatelessWidget {
  final text;
  final onPressed;
  final textColor;
  final buttonColor;
  final double height ;
  final double width ;

  RectangularButton({
    @required this.text,
    @required this.onPressed,
    this.textColor = Colors.black,
    this.buttonColor = primaryColor,
    this.width = double.infinity,
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: this.height,
      minWidth: this.width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      color: this.buttonColor,
      textColor: this.textColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          this.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
