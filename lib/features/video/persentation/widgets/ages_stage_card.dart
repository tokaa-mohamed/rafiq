import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/features/video/domain/entities/age_statge_entity.dart';

class AgeStageCard extends StatelessWidget {
  final AgeStageEntity stage;
  final VoidCallback onTap;

  const AgeStageCard({super.key, required this.stage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // الجزء الخاص بالنصوص (الشمال)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stage.ageRange,
                    style: AppTextStyles.bold16cairo.copyWith(color: const Color(0xFFC4D35D)),
                  ),
                  4.verticalSpace,
                  Text(
                    stage.title,
                    style: AppTextStyles.bold16cairo.copyWith(color: AppColors.grey2),
                  ),
                  8.verticalSpace,
                  Text(
                    stage.description,
                    style: AppTextStyles.regular16cairo.copyWith(color: AppColors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            12.horizontalSpace,
            // جزء الصورة (اليمين)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                stage.imagePath,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}