import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/core/routes/app_routes.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/apptextformfield.dart';
import 'package:rafiq/core/widgets/custom_appbar.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';
import 'package:rafiq/features/auth/persentation/logic/signin_cubit.dart';
import 'package:rafiq/features/auth/persentation/logic/signin_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> isPasswordObscure = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // 3. تنظيف الذاكرة (Memory Management)
    userNameController.dispose();
    passwordController.dispose();
    isPasswordObscure.dispose(); // لازم نقفل الـ notifier برضه
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.babypink,
            appBar:  CustomAppBar(title: "Login"),

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
                  // --- Header ---

                  // --- Username Field ---
                  _buildLabel('User Name'),
                  AppTextFormField(
                    hintText: 'monther_21',
                    controller: userNameController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                    suffixIcon: const Icon(Icons.person_outline, color: AppColors.secondaryLightactive),
                    validator: (value) => (value == null || value.isEmpty) ? 'Please enter your username' : null,
                  ),

                  _buildLabel('Password'),
                  ValueListenableBuilder<bool>(
                    valueListenable: isPasswordObscure,
                    builder: (context, obscureValue, child) {
                      return AppTextFormField(
                        hintText: 'e.g.monther-*99',
                        isObscureText: obscureValue,
                        controller: passwordController,
                        prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.grey1),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            isPasswordObscure.value = !isPasswordObscure.value;
                          },
                          child: Icon(
                            obscureValue ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: AppColors.secondaryLightactive,
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty) ? 'Incorrect password' : null,
                      );
                    },
                  ),

                  // --- Forget Password ---
                  _buildForgetPassword(context),
                  20.verticalSpace,

                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        context.go(AppRouter.homeView);
                      } else if (state is LoginError) {
                        _showErrorSnackBar(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text: state is LoginLoading ? 'Logging in...' : 'Login',
                        onPressed: state is LoginLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().login(
                                        userNameController.text,
                                        passwordController.text,
                                      );
                                }
                              },
                        backgroundColor: state is LoginLoading ? Colors.grey : AppColors.primaryNormalActive,
                        textColor: Colors.white,
                        height: 48.h,
                      );
                    },
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



  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 12.h),
      child: Text(
        label,
        style: AppTextStyles.bold16cairo.copyWith(color: Colors.black),
      ),
    );
  }

  Widget _buildForgetPassword(BuildContext context) {
    return Align(
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
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}