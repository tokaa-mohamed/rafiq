import 'package:dio/dio.dart';
import 'package:rafiq/features/chatbot_and_assessment/data/models/chatmodel.dart';
abstract class ChatRemoteDataSource {
  Future<ChatModel> sendMessage(String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSourceImpl({required this.dio});

  @override
  Future<ChatModel> sendMessage(String message) async {
    try {
      const String url = 'https://8be3950d-7bfe-4475-a12e-556b54716257.mock.pstmn.io';
      
      final response = await dio.post(
        url,
        data: {'message': message},
      );

      if (response.statusCode == 200) {
        return ChatModel.fromJson(response.data);
      } else {
        throw Exception("Server Error with status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Network Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }
}