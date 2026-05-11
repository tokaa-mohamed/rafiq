import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle? textstyle;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final BorderSide? borderSide;
  final double? width; // إضافة العرض
  final double? height; 
  
  // إضافة الطول
   final Icon? icon;
  const CustomButton({
    super.key,
    required this.text,
     this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.borderSide,
    this.width,
    this.height, 
    this.icon ,
    this.textstyle
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity, 
      height: height?.h ?? 35.h, 
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xffB6C93B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius?.r ?? 25.r),
            side: borderSide ?? BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}