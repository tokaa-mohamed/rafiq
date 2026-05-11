import '../entities/chat_entity.dart';

abstract class ChatRepository {
  Future<ChatMessage> sendMessage(String message);
}