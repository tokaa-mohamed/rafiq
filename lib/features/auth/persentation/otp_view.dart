import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/core/routes/app_routes.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.babypink,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                      "Enter your OTP code",
                      style: AppTextStyles.extrabold28cairo.copyWith(
                        color: AppColors.primaryNormal,    
                      ),
                    ),
                  ),

              20.verticalSpace,

Text(
                      "We just sent you a messege , please open it and enter the OTP code in that messege below to identify your account.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regular20cairo.copyWith(
                        color: AppColors.grey,    
                        height: 1.5,
                      ),
                    ),
              35.verticalSpace,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOtpBox(first: true, last: false),
                  _buildOtpBox(first: false, last: false),
                  _buildOtpBox(first: false, last: false),
                  _buildOtpBox(first: false, last: true),
                ],
              ),

              35.verticalSpace,

              CustomButton(
                text: 'Confirm',
                onPressed: () {
                                           context.push(AppRouter.createNewPasswordView);

                },
                backgroundColor: AppColors.primaryNormalActive,
                textColor: Colors.white,
                height: 48.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox({required bool first, required bool last}) {
    return Container(
      height: 70.h,
      width: 64.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryNormal, width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus(); 
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus(); 
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: AppTextStyles.bold16cairo.copyWith(fontSize: 24.sp),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1), 
          FilteringTextInputFormatter.digitsOnly, 
        ],
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "-", 
        ),
      ),
    );
  }
}