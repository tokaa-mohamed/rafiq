import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';

class CategoryVideoCard extends StatelessWidget {
  final String title;
  final String description;
   final IconData icon ;
  final VoidCallback onTap;

  const CategoryVideoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primaryNormal.withOpacity(0.2)), // الحدود المنقطة ممكن تتعمل بـ CustomPainter بس ده كشكل جمالي قريب
        ),
        child: Column(
          children: [
            // الجزء العلوي (الخلفية الملونة مع الأيقونة)
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4E8), // لون الهيدر في الصورة
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: Center(
                child: Icon(Icons.family_restroom_outlined),
              ),
            ),
            // الجزء السفلي (النصوص والزرار)
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.bold16cairo.copyWith(color: Colors.black)),
                        4.verticalSpace,
                        Text(description, style: AppTextStyles.regular14cairo.copyWith(color: Colors.grey)),
                      ],
                    ),
                  ),
                  // زرار السهم
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F4E8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_forward_ios, size: 14.sp, color: const Color(0xFF9DB454)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}