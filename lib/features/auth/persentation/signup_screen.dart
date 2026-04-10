import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/apptextformfield.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController fullNameController;
  late TextEditingController userNameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    userNameController.dispose();
    phoneController.dispose();
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
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: AppColors.black, size: 28.sp),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),

                  10.verticalSpace,
                  Center(
                    child: Text(
                      "SignUp",
                      style: AppTextStyles.extrabold28cairo.copyWith(color: AppColors.primaryNormal),
                    ),
                  ),

                  buildLabel('Full Name'),
                  AppTextFormField(
                    hintText: 'Toka Mohamed',
                    controller: fullNameController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                    suffixIcon: const Icon(Icons.person_outline, color: AppColors.secondaryLightactive),
                    validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                  ),

                  buildLabel('Phone Number'),
                  AppTextFormField(
                    hintText: '01090895795',
                    controller: phoneController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                    suffixIcon: const Icon(Icons.phone_outlined, color: AppColors.secondaryLightactive),
                    validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                  ),

                  buildLabel('Password'),
                  AppTextFormField(
                    hintText: '********',
                    isObscureText: isPasswordObscure,
                    controller: passwordController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => isPasswordObscure = !isPasswordObscure),
                      icon: Icon(isPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      color: AppColors.secondaryLightactive,
                    ),
                    validator: (value) => (value == null || value.length < 8) ? 'Min 8 chars' : null,
                  ),

                  buildLabel('Confirm Password'),
                  AppTextFormField(
                    hintText: '********',
                    isObscureText: isConfirmPasswordObscure,
                    controller: confirmPasswordController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => isConfirmPasswordObscure = !isConfirmPasswordObscure),
                      icon: Icon(isConfirmPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      color: AppColors.secondaryLightactive,
                    ),
                    validator: (value) => (value != passwordController.text) ? 'Password do not match' : null,
                  ),

                  20.verticalSpace,
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                    },
                    backgroundColor: AppColors.primaryNormalActive,
                    textColor: Colors.white,
                    height: 45.h,
                  ),

                  20.verticalSpace,
                  Row(
                    children: [
                      const Expanded(child: Divider(thickness: 1, color: Color(0xFFC2C2C2))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text("Or SignUp with", style: AppTextStyles.regular14cairo.copyWith(color: AppColors.grey1)),
                      ),
                      const Expanded(child: Divider(thickness: 1, color: Color(0xFFC2C2C2))),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socialIcon('assets/images/google.svg'),
                      25.horizontalSpace,
                      socialIcon('assets/images/Property 1=logos_facebook.svg'),
                    ],
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );

      
  }

  Widget socialIcon(String asset) {
    return GestureDetector(
      onTap: () {},
      child: SvgPicture.asset(asset, width: 40.w, height: 40.h),
    );
  }

  Widget buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h, top: 12.h),
      child: Text(
        label,
        style: AppTextStyles.bold16cairo.copyWith(color: AppColors.black),
      ),
    );
  }
}