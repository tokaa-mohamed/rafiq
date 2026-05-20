import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/widgets/app_generic_card.dart';
import 'package:rafiq/features/video/persentation/widgets/category_video_header.dart';
import 'category_video_card_content.dart';

class CategoryVideoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
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
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: AppGenericCard(
        onTap: onTap,
        height: 270.h ,
        color: Colors.white,
        borderRadius: 8.r,
        border: Border.all(color: AppColors.primaryNormal.withOpacity(0.2)),
        child: Column(
          children: [
            CategoryVideoCardHeader(icon: icon),
            CategoryVideoCardContent(
              title: title,
              description: description,
            ),
          ],
        ),
      ),
    );
  }
}