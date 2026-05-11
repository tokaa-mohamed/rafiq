// هذا الكلاس يمثل البيانات الأساسية للنتيجة
class AssessmentResult {
  final String mainTrait;
  final String description;
  final List<TraitScore> scores;
  final List<String>? guidelines;

  final int confidenceScore; 
  final Map<String, double> dimensionScores; // لـ Lead, Curi, Ctrl, Focu

  AssessmentResult({
    required this.mainTrait,
    required this.description,
    required this.scores,
    this.guidelines,
this.confidenceScore = 82, 
this.dimensionScores = const {"Lead": 82, "Curi": 77, "Ctrl": 41, "Focu": 52},  });
}

// كلاس فرعي للنسب المئوية
class TraitScore {
  final String name;
  final int score;
  final String description;

  TraitScore({
    required this.name, 
    required this.score, 
    required this.description,
    
  });
}