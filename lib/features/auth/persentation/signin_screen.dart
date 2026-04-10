import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/core/routes/app_routes.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/apptextformfield.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController userNameController;
  late TextEditingController passwordController;

  bool isPasswordObscure = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
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
                      icon: Icon(Icons.arrow_back, color: AppColors.black, size: 28.sp),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),

                  20.verticalSpace, 
                  Center(
                    child: Text(
                      "Login",
                      style: AppTextStyles.extrabold28cairo.copyWith(color: AppColors.primaryNormal),
                    ),
                  ),
                  
                  40.verticalSpace, 

                  buildLabel('User Name'),
                  AppTextFormField(
                    hintText: 'monther_21',
                    hintStyle: AppTextStyles.regular14cairo.copyWith(color: AppColors.grey1),
                    controller: userNameController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                    suffixIcon: const Icon(Icons.person_outline, color: AppColors.secondaryLightactive),
                    validator: (value) => (value == null || value.isEmpty) ? 'Please enter your username' : null,
                  ),

                  buildLabel('Password'),
                  AppTextFormField(
                    hintText: 'e.g.monther-*99',
                    hintStyle: AppTextStyles.regular14cairo.copyWith(color: AppColors.grey1),
                    isObscureText: isPasswordObscure,
                    controller: passwordController, 
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => isPasswordObscure = !isPasswordObscure),
                      child: Icon(
                        isPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppColors.secondaryLightactive,
                      ),
                    ),
                    validator: (value) => (value == null || value.isEmpty) ? 'Incorrect password' : null,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                          onPressed: () => context.push(AppRouter.forgetPassword),
                      child: Text(
                        "Forget password ?",
                        style: AppTextStyles.regular14cairo.copyWith(
                          color: Colors.black12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  20.verticalSpace,

                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                      }
                    },
                    backgroundColor: AppColors.primaryNormalActive,
                    textColor: Colors.white,
                    height: 48.h,
                  ),

                  30.verticalSpace,
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