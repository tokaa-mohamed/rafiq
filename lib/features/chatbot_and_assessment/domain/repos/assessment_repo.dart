
import 'package:rafiq/features/chatbot_and_assessment/domain/entities/assessment_q.dart';

abstract class AssessmentRepository {
  
  Future<List<AssessmentQuestion>> getQuestions();
    Future<void> submitAssessment({
    required String userId,
    required int childAge,
    required List<AssessmentQuestion> answeredQuestions,
  });

}

