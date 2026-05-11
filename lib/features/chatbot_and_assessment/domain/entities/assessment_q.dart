// features/assessment/domain/entities/assessment_question.dart
class AssessmentQuestion {
  final int id;
  final String questionText;
  final List<String> options;
  final String? selectedAnswer;

  AssessmentQuestion({
    required this.id,
    required this.questionText,
    required this.options,
    this.selectedAnswer,
  });

  AssessmentQuestion copyWith({String? selectedAnswer}) {
    return AssessmentQuestion(
      id: id,
      questionText: questionText,
      options: options,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }
}