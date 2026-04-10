import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/core/routes/app_routes.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/apptextformfield.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late TextEditingController phoneController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
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
                      "Forget password",
                      style: AppTextStyles.extrabold28cairo.copyWith(
                        color: AppColors.primaryNormal,    
                      ),
                    ),
                  ),
                  
                  18.verticalSpace, 

                  Center(
                    child: Text(
                      "Please enter your Phone Number. You will receive an OTP code to create a new password via Phone",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regular20cairo.copyWith(
                        color: AppColors.grey,    
                      ),
                    ),
                  ),

                  43.verticalSpace,

                  buildLabel('Phone Number'),
                  
                  AppTextFormField(
                    hintText: '01090895795',
                    hintStyle: AppTextStyles.regular14cairo.copyWith(color: AppColors.secondaryNormal),
                    controller: phoneController,
                    prefixIcon: const Icon(Icons.check_circle_outline, color: AppColors.primaryNormalActive), // تقدري تغيري اللون ده بناءً على الـ Validtaion
                    suffixIcon: const Icon(Icons.phone_outlined, color: AppColors.primaryNormalActive), // أيقونة الهاتف الـ الـ primary اللي في الصورة
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length != 11) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),

                  43.verticalSpace,

                  CustomButton(
                    text: 'Send',

                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                         context.push(AppRouter.otpView);
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