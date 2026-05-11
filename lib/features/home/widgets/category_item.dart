import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryItem({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.w, 
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r), 
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4), 
              ),
            ],
          ),
          alignment: Alignment.center, 
          child: Container(
            width: 70.w, 
            height: 70.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: AppColors.primaryNormal.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
        ),
        12.verticalSpace, 
        Text(
          title, 
          style: AppTextStyles.bold16cairo,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}