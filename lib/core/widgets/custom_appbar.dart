import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_styles.dart'; // لو بتستخدمي screenutil

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showLogo;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showLogo = true, // اختيارية لو حبيتي تخفي اللوجو في صفحة معينة
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title, 
        style: AppTextStyles.bold16cairo.copyWith(color: Colors.black),
      ),
      centerTitle: true,
      actions: actions ?? [
        if (showLogo)
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: SvgPicture.asset(
              'assets/images/rafig_logo.svg',
              width: 56.w,
              height: 38.h,
            ),
          ),
      ],
    );
  }

  @override
  // ده الجزء المسؤول عن تحديد حجم الـ AppBar
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}