import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Profile", style: AppTextStyles.extrabold28cairo.copyWith(color: Colors.black)),
                      SvgPicture.asset('assets/images/rafig_logo.svg',
                        placeholderBuilder: (context) => CircularProgressIndicator(),

                       width: 56.w,
                       height: 38.h,), 
                    ],
                  ),
                ),

                30.verticalSpace,

Center(
  child: SizedBox(
    width: 140.w, 
    height: 140.h,
    child: Stack(
      children: [
Align(
  alignment: Alignment.center,
  child: CircleAvatar(
    radius: 65.r,
    backgroundColor: AppColors.primaryNormal, 
    child: ClipOval(
      child: SvgPicture.asset(
        'assets/images/Background+Border.svg',
        color: Colors.black,
        width: 124.r, 
        height: 124.r,
        fit: BoxFit.cover, 
      ),
    ),
  ),
),
        Positioned(
          bottom: 10.h, 
          right: 10.w,  
          child: Container(
            padding: EdgeInsets.all(4.w), 
            decoration: const BoxDecoration(
              color: Colors.white, 
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.primaryNormal,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),
                15.verticalSpace,

                Text("Ahmed Hassan", style: AppTextStyles.bold28merr.copyWith(color: AppColors.grey2)),
                Text("Parenting Enthusiast", style: AppTextStyles.regular16merr.copyWith(color: AppColors.grey)),

                30.verticalSpace,

                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildProfileRow("First Name", "Ahmed"),
                      const Divider(height: 30),
                      _buildProfileRow("Last Name", "Hassan"),
                      const Divider(height: 30),
                      _buildProfileRow("Phone Number", "+1 234 567 890"),
                      const Divider(height: 30),
                      _buildProfileRow("Age", "28"),
                      const Divider(height: 30),
                      _buildProfileRow("Status", "Married"),
                      const Divider(height: 30),
                      _buildProfileRow("Number of Children", "2"),
                    ],
                  ),
                ),

                40.verticalSpace,

                CustomButton(
                  text: 'Edit Profile',
                  onPressed: () {},
                  backgroundColor: AppColors.primaryNormalActive,
                  textColor: Colors.white,
                  height: 50.h,
                  icon: const Icon(Icons.edit_note, color: Colors.white), 
                ),
                
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.regular14cairo.copyWith(color:AppColors.grey )),
        Text(value, style: AppTextStyles.bold16cairo.copyWith(color: AppColors.grey2)),
      ],
    );
  }
}