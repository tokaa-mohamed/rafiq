// features/assessment/presentation/pages/assessment_result_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';
import 'package:rafiq/features/book_session/persentation/screens/select_date.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/assess_result_cubit.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/assess_result_state.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/widgets/assess_charts.dart'; 
import '../widgets/result_tile.dart';

class AssessmentResultPage extends StatelessWidget {
  const AssessmentResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title:  Text('Assessment Result',style: AppTextStyles.bold24cairo.copyWith(color: AppColors.darkblack),), 
        centerTitle: true, 
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<AssessmentResultCubit, AssessmentResultState>(
        builder: (context, state) {
          if (state.status == AssessmentResultStatus.loading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xffB6C93B)));
          }
          
          if (state.result == null) {
            return const Center(child: Text("Results not available."));
          }

          final result = state.result!;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // عشان العناوين تبقى متسنترة
              children: [
                // 1. النتيجة الرئيسية
                Text(
                  'Your Child is a ${result.mainTrait}', 
                  textAlign: TextAlign.center, 
                  style: AppTextStyles.bold20cairo.copyWith(color: AppColors.darkblack),
                ),
                SizedBox(height: 12.h),
                Text(
                  result.description, 
                  textAlign: TextAlign.center, 
                  style: AppTextStyles.regular14cairo.copyWith(color: AppColors.grey8)
                ),
                
                SizedBox(height: 16.h),
                ...result.scores.map((s) => ResultTile(
                  icon: _getIconForTrait(s.name),
                  title: s.name,
                  score: s.score,
                  description: s.description,
                )),

SizedBox(height: 8.h),
AssessmentChartsSection(
  confidence: result.confidenceScore,
  dimensions: result.dimensionScores,
),
                SizedBox(height: 32.h), // مسافة كافية بدل الـ Spacer


                // 4. زرار الإنهاء
                CustomButton(
                  text: 'Done',
                  height: 55.h,
                  borderRadius: 12.r,
                  onPressed: () {

                  },
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  backgroundColor: Colors.transparent,
                  text: 'Retake Assessment',
                  borderSide: BorderSide(color: AppColors.primaryNormalActive,),
                  textstyle:AppTextStyles.regular16cairo.copyWith(color: AppColors.primaryNormalActive),
                  height: 55.h,
                  borderRadius: 12.r,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getIconForTrait(String traitName) {
    switch (traitName) {
      case 'Leader': return Icons.star;
      case 'Truth-Seeker': return Icons.search;
      case 'The Thinker': return Icons.lightbulb;
      default: return Icons.person;
    }
  }
}