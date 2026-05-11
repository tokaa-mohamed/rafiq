import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart'; 
import 'package:rafiq/core/widgets/apptextformfield.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';

class CreatePostSheet extends StatefulWidget {
  const CreatePostSheet({super.key});

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // عشان مياخدش خلفية الـ Dialog الافتراضية
      child: Container(
        width: 0.9.sw, // بياخد 90% من عرض الشاشة
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r), // مدور من كل الزوايا
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // بيكبر على قد المحتوى اللي جواه
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الهيدر: العنوان وزرار الإغلاق
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Create Post",
                  style: AppTextStyles.bold16cairo.copyWith(color: Colors.black),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, size: 22.sp, color: Colors.grey),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const Divider(height: 20), // خط فاصل رفيع
            
            // بيانات الأدمن (رفيق)
            Row(
              children: [
CircleAvatar(
  radius: 24.r, 
  backgroundColor: Colors.transparent,
  backgroundImage: const AssetImage('assets/images/daii.png'),
  
),                12.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            const        Text("Rafiq", style: AppTextStyles.extrabold16cairo),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color:  AppColors.grey5, // لون أزرق خفيف للأدمن
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "Admin",
                        style: TextStyle(
                          color: AppColors.grey3,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            20.verticalSpace,

            // منطقة كتابة البوست
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 150.h, // كبرنا الارتفاع الأدنى للكارد
                maxHeight: 300.h, // عشان لو الكلام كتر أوي يعمل Scroll جوه
              ),
              child: AppTextFormField(
                controller: _postController,
                hintText: "What's on your mind, Rafiq?",
                hintStyle: AppTextStyles.bold20cairo,
             //   maxLines: null, // بيسمح بكتابة عدد لا نهائي من الأسطر
                keyboardType: TextInputType.multiline,
                validator: (value) => null,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              //  contentPadding: EdgeInsets.zero,
              ),
            ),
            
            25.verticalSpace,


            CustomButton(
              text: 'Publish Post',
              onPressed: () {
//context.push('/edit-profile', extra: user); 
              },
              backgroundColor: AppColors.primaryNormalActive,
              textColor: Colors.white,
              height: 50.h,
            //  icon: const Icon(Icons.edit_note, color: Colors.white),
            ),

          ],
        ),
      ),
    );
  }

  void _handlePublish(BuildContext context) {
    if (_postController.text.trim().isNotEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Post Published Successfully!"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }
}