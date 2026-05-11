import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/core/di/dependency_injection.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';
import 'package:rafiq/features/profile/domain/entities/profile_entity.dart';
import 'package:rafiq/features/profile/persentation/edit_profile.dart';
import 'package:rafiq/features/profile/persentation/logic/profile_cubit.dart';
import 'package:rafiq/features/profile/persentation/logic/profile_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // بنعمل تفعيل للـ Cubit وبنطلب الداتا فوراً
      create: (context) => getIt<ProfileCubit>()..getProfile(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primaryNormal),
                );
              } else if (state is ProfileSuccess) {
                return _buildProfileBody(context, state.user);
              } else if (state is ProfileError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message, style: AppTextStyles.bold16cairo),
                      TextButton(
                        onPressed: () => context.read<ProfileCubit>().getProfile(),
                        child: const Text("Retry"),
                      )
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  // --- الـ Body الأساسي ---
  Widget _buildProfileBody(BuildContext context, ProfileEntity user) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            _buildHeader(),
            30.verticalSpace,
            _buildProfileImage(),
            15.verticalSpace,
            Text(
              user.fullName,
              style: AppTextStyles.bold28merr.copyWith(color: AppColors.grey2),
            ),
            Text(
              user.bio,
              style: AppTextStyles.regular16merr.copyWith(color: AppColors.grey),
            ),
            30.verticalSpace,
            _buildInfoCard(user),
            40.verticalSpace,
            CustomButton(
              text: 'Edit Profile',
              onPressed: () {
context.push('/edit-profile', extra: user); 
              },
              backgroundColor: AppColors.primaryNormalActive,
              textColor: Colors.white,
              height: 50.h,
              icon: const Icon(Icons.edit_note, color: Colors.white),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Profile",
            style: AppTextStyles.extrabold28cairo.copyWith(color: Colors.black),
          ),
          SvgPicture.asset(
            'assets/images/rafig_logo.svg',
            width: 56.w,
            height: 38.h,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
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
                    // ignore: deprecated_member_use
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
                  child: Icon(Icons.edit, color: Colors.white, size: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(ProfileEntity user) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildProfileRow("First Name", user.firstName),
          const Divider(height: 30),
          _buildProfileRow("Last Name", user.lastName),
          const Divider(height: 30),
          _buildProfileRow("Phone Number", user.phone),
          const Divider(height: 30),
          _buildProfileRow("Age", user.age.toString()),
          const Divider(height: 30),
          _buildProfileRow("Status", user.status),
          const Divider(height: 30),
          _buildProfileRow("Number of Children", user.childrenCount.toString()),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.regular14cairo.copyWith(color: AppColors.grey),
        ),
        Text(
          value,
          style: AppTextStyles.bold16cairo.copyWith(color: AppColors.grey2),
        ),
      ],
    );
  }
}