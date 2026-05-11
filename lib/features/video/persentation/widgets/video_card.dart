import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/features/video/domain/entities/video_entity.dart';

class VideoCard extends StatelessWidget {
  final VideoEntity video;
  final VoidCallback onTap;

  const VideoCard({super.key, required this.video, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: Image.asset(video.thumbnailUrl, height: 180.h, width: double.infinity, fit: BoxFit.cover),
                ),
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: const Color(0xFFC4D35D).withOpacity(0.9),
                  child: const Icon(Icons.play_arrow, color: Colors.white, size: 30),
                ),
                Positioned(
                  bottom: 10.h,
                  right: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(4.r)),
                    child: Text(video.duration, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(video.title, style: AppTextStyles.bold16cairo),
                  4.verticalSpace,
                  Text(video.description, style: AppTextStyles.regular14cairo.copyWith(color: Colors.grey), maxLines: 2),
                  12.verticalSpace,
                  Row(
                    children: [
                      Icon(Icons.trending_up, size: 16.sp, color: const Color(0xFFC4D35D)),
                      6.horizontalSpace,
                      Text(video.tag, style: AppTextStyles.bold16cairo.copyWith(color: const Color(0xFFC4D35D))),
                    ],
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