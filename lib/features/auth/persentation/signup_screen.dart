import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/core/routes/app_routes.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/apptextformfield.dart';
import 'package:rafiq/core/widgets/custom_appbar.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';
import 'package:rafiq/features/auth/domain/entities/sign_up_entity.dart';
import 'package:rafiq/features/auth/persentation/logic/signup_cubit.dart';
import 'package:rafiq/features/auth/persentation/logic/signup_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // 1. Controllers & Keys
  late TextEditingController fullNameController;
  late TextEditingController userNameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 2. ValueNotifiers for Local UI State (Performance Optimization)
  final ValueNotifier<bool> isPasswordObscure = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isConfirmPasswordObscure = ValueNotifier<bool>(true);

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
    isPasswordObscure.dispose();
    isConfirmPasswordObscure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: "Sign Up"),

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
                  
                  _buildLabel('Full Name'),
                  AppTextFormField(
                    hintText: 'Toka Mohamed',
                    controller: fullNameController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                    suffixIcon: const Icon(Icons.person_outline, color: AppColors.secondaryLightactive),
                    validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                  ),

                  _buildLabel('Phone Number'),
                  AppTextFormField(
                    hintText: '01090895795',
                    controller: phoneController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                    suffixIcon: const Icon(Icons.phone_outlined, color: AppColors.secondaryLightactive),
                    validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                  ),

                  _buildLabel('Password'),
                  ValueListenableBuilder(
                    valueListenable: isPasswordObscure,
                    builder: (context, obscure, _) {
                      return AppTextFormField(
                        hintText: '********',
                        isObscureText: obscure,
                        controller: passwordController,
                        prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                        suffixIcon: IconButton(
                          onPressed: () => isPasswordObscure.value = !isPasswordObscure.value,
                          icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                          color: AppColors.secondaryLightactive,
                        ),
                        validator: (value) => (value == null || value.length < 8) ? 'Min 8 chars' : null,
                      );
                    },
                  ),

                  _buildLabel('Confirm Password'),
                  ValueListenableBuilder(
                    valueListenable: isConfirmPasswordObscure,
                    builder: (context, obscure, _) {
                      return AppTextFormField(
                        hintText: '********',
                        isObscureText: obscure,
                        controller: confirmPasswordController,
                        prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                        suffixIcon: IconButton(
                          onPressed: () => isConfirmPasswordObscure.value = !isConfirmPasswordObscure.value,
                          icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                          color: AppColors.secondaryLightactive,
                        ),
                        validator: (value) => (value != passwordController.text) ? 'Password do not match' : null,
                      );
                    },
                  ),

                  20.verticalSpace,
                  
                  // ✅ الـ BlocConsumer للتعامل مع حالات الـ Signup
                  BlocConsumer<SignupCubit, SignupState>(
                    listener: (context, state) {
                      if (state is SignupSuccess) {
                        context.go(AppRouter.homeView);
                      } else if (state is SignupError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text: state is SignupLoading ? 'Creating Account...' : 'Sign Up',
                        onPressed: state is SignupLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  context.read<SignupCubit>().signup(
                                    SignupRequestEntity(
                                      fullName: fullNameController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                        backgroundColor: state is SignupLoading ? Colors.grey : AppColors.primaryNormalActive,
                        textColor: Colors.white,
                        height: 45.h,
                      );
                    },
                  ),

                  20.verticalSpace,
                  _buildSocialDivider(),
                  20.verticalSpace,
                  _buildSocialIcons(),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildSocialDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1, color: Color(0xFFC2C2C2))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text("Or SignUp with", style: AppTextStyles.regular14cairo.copyWith(color: AppColors.grey1)),
        ),
        const Expanded(child: Divider(thickness: 1, color: Color(0xFFC2C2C2))),
      ],
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon('assets/images/google.svg'),
        25.horizontalSpace,
        _socialIcon('assets/images/Property 1=logos_facebook.svg'),
      ],
    );
  }

  Widget _socialIcon(String asset) {
    return GestureDetector(
      onTap: () {}, 
      child: SvgPicture.asset(asset, width: 40.w, height: 40.h),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h, top: 12.h),
      child: Text(
        label,
        style: AppTextStyles.bold16cairo.copyWith(color: AppColors.black),
      ),
    );
  }
}