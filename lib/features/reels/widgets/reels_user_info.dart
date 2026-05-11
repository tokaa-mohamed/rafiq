import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
class ReelsUserInfo extends StatelessWidget {
  final String userName;
  final String description;

  const ReelsUserInfo({
    super.key,
    required this.userName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,

backgroundImage: const AssetImage('assets/images/daii.png'),

              ),
              8.horizontalSpace,
              Text(
                userName,
                style:AppTextStyles.bold14inter.copyWith(color: Colors.white) ,
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            description,
            style:                AppTextStyles.bold14inter.copyWith(color: Colors.white) ,

            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          20.verticalSpace, 
        ],
      ),
    );
  }
}