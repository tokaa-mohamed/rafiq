// features/assessment/presentation/cubit/assessment_result_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/entities/assess_result.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/assess_result_state.dart';

class AssessmentResultCubit extends Cubit<AssessmentResultState> {
  AssessmentResultCubit() : super(const AssessmentResultState());

  void loadResults() {
    emit(state.copyWith(status: AssessmentResultStatus.loading));
    
    // محاكاة تأخير بسيط كأننا بنجيب داتا من الـ API
    Future.delayed(const Duration(milliseconds: 500), () {
      final mockResult = AssessmentResult(
        mainTrait: 'Leader',
        description: 'Based on our AI evaluation, your child shows strong independent thinking and natural leadership qualities in social settings.',
        scores: [
          TraitScore(name: 'Leader', score: 78, description: 'Thrives in environments where they can take initiative and lead peer groups.'),
          TraitScore(name: 'Truth-Seeker', score: 71, description: 'Highly analytical and enjoys exploring new experiences.'),
          TraitScore(name: 'The Thinker', score: 70, description: 'Deeply observant and needs quiet time to process complex challenges.'),
        ],
        // إضافة الـ Guidelines اللي هتظهر في الكروت اللي بالطول
        guidelines: [
          "Encourage them to lead small group activities or playdates.",
          "Provide puzzles and logic games to satisfy their analytical mind.",
          "Set aside 'quiet time' daily for them to reflect and observe.",
          "Involve them in decision-making processes to build confidence."
        ],
      );

      emit(state.copyWith(status: AssessmentResultStatus.loaded, result: mockResult));
    });
  }
}