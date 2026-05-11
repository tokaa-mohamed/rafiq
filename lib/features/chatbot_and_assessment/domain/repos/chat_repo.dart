import 'package:rafiq/features/chatbot_and_assessment/data/datasource/dataresourceremote.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/repos/chat_repo_impl.dart';

import '../../domain/entities/chat_entity.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ChatMessage> sendMessage(String message) async {
    try {
      final chatModel = await remoteDataSource.sendMessage(message);
      
      
      return chatModel; 
    } catch (e) {
      throw Exception("Failed to send message: $e");
    }
  }
}