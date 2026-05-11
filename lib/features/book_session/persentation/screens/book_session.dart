// features/chatbot_and_assessment/persentation/screens/book_session_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart'; // تأكدي من مسار الـ CustomButton
import 'package:rafiq/features/book_session/persentation/screens/select_date.dart';
import 'package:rafiq/features/book_session/persentation/widgets/floating_style_button.dart';
import '../widgets/floating_consultation_card.dart';

class BookSessionScreen extends StatefulWidget {
  const BookSessionScreen({super.key});

  @override
  State<BookSessionScreen> createState() => _BookSessionScreenState();
}

class _BookSessionScreenState extends State<BookSessionScreen> {
  int selectedIndex = 1; // موعد افتراضي مختار

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.babypink,
      appBar: AppBar(
        title:  Text('Book Session',style: AppTextStyles.bold24cairo.copyWith(color: AppColors.secondaryDarker),),
        centerTitle: true,
                leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back,color: AppColors.darkblack,)),

        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            
            const FloatingConsultationCard(),
            
            SizedBox(height: 30.h),
            
            // 2. قسم المواعيد
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text('Available Slots', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            ),
            
            SizedBox(height: 120.h, // تحديد طول الـ List
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return BookingSlotTile(
                    day: 'Today',
                    time: '${14 + index}:00',
                    isSelected: selectedIndex == index,
                    onTap: () => setState(() => selectedIndex = index),
                  );
                },
              ),
            ),
            
            SizedBox(height: 40.h),
            
            // 3. زرار الحجز
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomButton(
                text: 'Confirm Booking',
                height: 55.h,
                borderRadius: 15.r,
                onPressed: () {
                                                                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const SelectDateScreen()),
                              );

                  // الـ Logic بتاع الحجز هنا
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}