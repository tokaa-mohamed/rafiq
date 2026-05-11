// features/assessment/presentation/pages/assessment_questionnaire_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/di/dependency_injection.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/assess_result.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/assess_cubit.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/assess_result_cubit.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/assess_state.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/widgets/assess_option_card.dart';

class AssessmentQuestionnairePage extends StatelessWidget {
  const AssessmentQuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>getIt<AssessmentCubit>()..loadQuestions(), 
      child: Scaffold(
        appBar: AppBar(title: 
         Center(child: Text('Question 2 of 6', style:  AppTextStyles.bold24cairo.copyWith(color: AppColors.darkblack) ))),
        body: BlocBuilder<AssessmentCubit, AssessmentState>(
          builder: (context, state) {
            if (state.status == AssessmentStatus.loading) return const Center(child: CircularProgressIndicator());
            if (state.currentQuestion == null) return const Center(child: Text("No Questions Found"));

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      
                         Text("Assessment Progress",  style:  AppTextStyles.bold16cairo.copyWith(color: AppColors.grey8),),

                    const     SizedBox(height: 10,),

                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(10),
                    minHeight: 10,
                    value: state.progress, color: AppColors.lightYellow, backgroundColor:AppColors.primaryLightActive),
                  const SizedBox(height: 30),
                  Text(state.currentQuestion!.questionText, textAlign: TextAlign.center, 
                    style: AppTextStyles.bold24inter.copyWith(color: AppColors.darkblack)),
                  const SizedBox(height: 30),
                  ...state.currentQuestion!.options.map((opt) => OptionCard(
                    text: opt,
                    isSelected: state.currentQuestion!.selectedAnswer == opt,
                    onTap: () => context.read<AssessmentCubit>().selectAnswer(opt),
                  )),
                  const Spacer(),
CustomButton(
  text: state.isLastQuestion ? 'Finish' : 'Next',
  height: 50,
  borderRadius: 10,
  onPressed: state.currentQuestion!.selectedAnswer != null
      ? () {
          if (state.isLastQuestion) {
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => BlocProvider(
      create: (context) => AssessmentResultCubit()..loadResults(), 
      child: const AssessmentResultPage(),
    ),
  ),
);

          } else {
            context.read<AssessmentCubit>().nextQuestion();
          }
        }
      : null,
  backgroundColor: state.currentQuestion!.selectedAnswer != null
      ? const Color(0xffB6C93B)
      : Colors.grey[300],
),
                ]
              ),
            );
          },
        ),
      ),
    );
  }
}