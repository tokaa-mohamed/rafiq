import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/entities/chat_entity.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/use_cases/send_message_usecase.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/chatbot_states.dart';

class ChatBloc extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  List<ChatMessage> _allMessages = [];

  ChatBloc(this.sendMessageUseCase) : super(ChatInitial());

  void sendMessage(String text) async {
    _allMessages.add(ChatMessage(text: text, isBot: false, timestamp: DateTime.now()));
    emit(ChatLoaded(List.from(_allMessages)));

    final response = await sendMessageUseCase.call(text);
    _allMessages.add(response);
    emit(ChatLoaded(List.from(_allMessages)));
  }
}
