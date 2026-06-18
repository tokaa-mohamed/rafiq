// features/chatbot_and_assessment/persentation/screens/logic/assess_result_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/entities/assess_result.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/entities/assessment_q.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/repos/assessment_repo.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/assess_result_state.dart';

class AssessmentResultCubit extends Cubit<AssessmentResultState> {
  final AssessmentRepository _assessmentRepository;

  AssessmentResultCubit(this._assessmentRepository) 
      : super(AssessmentResultState(status: AssessmentResultStatus.initial));
      
  Future<void> loadResults({
    required String userId,
    required int childAge,
    required List<AssessmentQuestion> answeredQuestions,
  }) async {
    emit(state.copyWith(status: AssessmentResultStatus.loading));
    
    try {
      final dio = Dio();
      
      final response = await dio.post(
        'https://your-backend-api.com/assessment/submit', 
        data: {
          "user_id": userId,
          "child_age": childAge,
          "answers": answeredQuestions.map((q) => {
            "question_id": q.id, 
            "score": q.selectedScore ?? 1, // الـ score المتسجل من اختيار المستخدم
          }).toList(),
          "behavior_signals": {}
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data as Map<String, dynamic>;
        
        if (responseData['ok'] == true) {
          final resultData = AssessmentResult.fromJson(responseData); 
          
          emit(state.copyWith(
            status: AssessmentResultStatus.loaded, 
            result: resultData,
          ));
        } else {
          emit(state.copyWith(status: AssessmentResultStatus.error, errorMessage: "Response not ok"));
        }
      } else {
        emit(state.copyWith(status: AssessmentResultStatus.error, errorMessage: "Server Error"));
      }
      
    } catch (e) {
      print("Error inside loadResults: $e");
      emit(state.copyWith(status: AssessmentResultStatus.error, errorMessage: e.toString()));
    }
  }
}