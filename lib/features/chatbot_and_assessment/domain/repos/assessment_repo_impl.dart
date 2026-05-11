// features/assessment/data/repositories/assessment_repository_impl.dart

import 'package:rafiq/features/chatbot_and_assessment/domain/entities/assessment_q.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/repos/assessment_repo.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  @override
  Future<List<AssessmentQuestion>> getQuestions() async {
    return [
      AssessmentQuestion(
        id: 1,
        questionText: "How does your child typically react in new social situations?",
        options: [
          "Very outgoing and excited",
          "Observes first, then joins",
          "Prefers to stay close to parents",
          "Depends on the environment"
        ],
      ),
      // هضيفلك 5 أسئلة dummy عشان الـ logic يكمل لـ 6
      ...List.generate(5, (index) => AssessmentQuestion(
        id: index + 2,
        questionText: "Assessment Question ${index + 2}?",
        options: ["Option A", "Option B", "Option C", "Option D"],
      )),
    ];
  }
}