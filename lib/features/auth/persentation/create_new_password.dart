import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/core/routes/app_routes.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/apptextformfield.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.babypink,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.black, size: 28.sp),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),

                  30.verticalSpace,

                  Center(
                    child: Text(
                      "Create new password",
                      style: AppTextStyles.extrabold28cairo.copyWith(
                        color: AppColors.primaryNormal,
                      ),
                    ),
                  ),

                  20.verticalSpace,

                  Center(
                    child: Text(
                      "Create your own new password to reset your account.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regular16merr.copyWith(
                        color: AppColors.grey1,
                        height: 1.4,
                      ),
                    ),
                  ),

                  35.verticalSpace,

                  buildLabel('New Password'),
                  AppTextFormField(
                    hintText: '*********',
               hintStyle: AppTextStyles.regular14cairo.copyWith(color: AppColors.secondaryNormal),

                    isObscureText: isPasswordObscure,
                    controller: passwordController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.primaryNormal),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => isPasswordObscure = !isPasswordObscure),
                      icon: Icon(isPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      color: AppColors.primaryNormal,
                    ),
                    validator: (value) => (value == null || value.length < 8) ? 'Must be at least 8 chars' : null,
                  ),

                  35.verticalSpace,

                  buildLabel('Confirm New Password'),
                  AppTextFormField(
                    hintText: '*********',
                                        hintStyle: AppTextStyles.regular14cairo.copyWith(color: AppColors.secondaryNormal),

                    isObscureText: isConfirmPasswordObscure,
                    controller: confirmPasswordController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.primaryNormal),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => isConfirmPasswordObscure = !isConfirmPasswordObscure),
                      icon: Icon(isConfirmPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      color: AppColors.primaryNormal,
                    ),
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  35.verticalSpace,

                  CustomButton(
                    text: 'Confirm',
                    onPressed: () {
                    context.push(AppRouter.successConfirmationView);

                    },
                    backgroundColor: AppColors.primaryNormalActive,
                    textColor: Colors.white,
                    height: 48.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 12.h), 
      child: Text(
        label,
        style: AppTextStyles.bold16cairo.copyWith(color: Colors.black),
      ),
    );
  }
}