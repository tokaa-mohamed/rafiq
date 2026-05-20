import 'package:dio/dio.dart';
import 'package:rafiq/features/chatbot_and_assessment/data/models/chatmodel.dart';
import 'package:dio/dio.dart';

abstract class ChatRemoteDataSource {
  Future<ChatModel> sendMessage(String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;
  bool useMock = false; 

  ChatRemoteDataSourceImpl({required this.dio});

@override
  Future<ChatModel> sendMessage(String message) async {
    if (useMock) {
      print("--- [CHAT] Using Mock Data ---");
      await Future.delayed(const Duration(seconds: 1));
      return ChatModel(
        text: "أهلاً بك يا صديقي! أنا رفيق أنا الـ Mock حالياً", 
        isBot: true, 
        timestamp: DateTime.now()
      );
    }

    try {
      const String url = 'https://ribatbackend-production.up.railway.app/chat';
      
      print("--- [CHAT] Sending Request to: $url ---");
      print("--- [CHAT] Payload: $message ---");

      final response = await dio.post(
        url,
        data: {
          "user_id": "temp_user_123",
          "messages": [
            {"role": "user", "content": message}
          ],
          "child_age": 7
        },
      ).timeout(const Duration(seconds: 15)); // زودنا timeout عشان لو السيرفر بطيء

      print("--- [CHAT] Response Status: ${response.statusCode} ---");
      print("--- [CHAT] Response Data: ${response.data} ---");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ChatModel.fromJson(response.data);
      } else {
        print("--- [CHAT] Server Returned Error Status ---");
        throw Exception("Server Error");
      }
    } on DioException catch (e) {
      print("--- [CHAT] Dio Error: ${e.type} ---");
      print("--- [CHAT] Dio Error Message: ${e.message} ---");
      print("--- [CHAT] Server Response Error: ${e.response?.data} ---");
      throw Exception("Network Error: ${e.message}");
    } catch (e) {
      print("--- [CHAT] Unknown Error: $e ---");
      throw Exception("Unexpected Error occurred");
    }
  }
  }