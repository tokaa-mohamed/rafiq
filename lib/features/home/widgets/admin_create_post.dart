import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/features/home/widgets/post_sheet.dart';
import 'package:rafiq/core/widgets/app_generic_card.dart'; 

class AdminCreatePostWidget extends StatelessWidget {
  const AdminCreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGenericCard(
      padding: 16.w,
      color: Colors.white,
      borderRadius: 16.r,
      shadow: BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage("assets/images/daii.png"),
          ),
          12.horizontalSpace,
          Expanded(
            child: GestureDetector(
              onTap: () => _showCreatePostDialog(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(color: const Color(0xFF96A53A), width: 1.5),
                ),
                child: Text(
                  "What's on your mind, Rafiq?",
                  style: AppTextStyles.regular14cairo.copyWith(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: const CreatePostSheet(),
        ),
      ),
    );
  }
}