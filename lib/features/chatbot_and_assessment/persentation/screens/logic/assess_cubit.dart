// features/assessment/presentation/cubit/assessment_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/entities/assessment_q.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/use_cases/get_assessment.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/assess_state.dart';

class AssessmentCubit extends Cubit<AssessmentState> {
  final GetAssessmentQuestions getAssessmentQuestions;

  AssessmentCubit(this.getAssessmentQuestions) : super(AssessmentState());

  Future<void> loadQuestions() async {
    emit(state.copyWith(status: AssessmentStatus.loading));
    try {
      final questions = await getAssessmentQuestions();
      emit(state.copyWith(status: AssessmentStatus.loaded, questions: questions));
    } catch (e) {
      emit(state.copyWith(status: AssessmentStatus.error));
    }
  }

  void selectAnswer(String answer) {
    final updatedQuestions = List<AssessmentQuestion>.from(state.questions);
    updatedQuestions[state.currentQuestionIndex] = 
        state.questions[state.currentQuestionIndex].copyWith(selectedAnswer: answer);
    emit(state.copyWith(questions: updatedQuestions));
  }

  void nextQuestion() {
    if (!state.isLastQuestion) {
      emit(state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1));
    }
  }
}