import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/entities/chat_entity.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/use_cases/send_message_usecase.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/chatbot_states.dart';

class ChatBloc extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  
  // شيلنا الـ (_) عشان الـ UI يقدر يقرأ اللستة ويعرضها
  final List<ChatMessage> allMessages = [];

  ChatBloc(this.sendMessageUseCase) : super(ChatInitial());

  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 1. إضافة رسالة المستخدم للـ List وإرسال الحالة للـ UI
    final userMsg = ChatMessage(
      text: text, 
      isBot: false, 
      timestamp: DateTime.now(),
    );
    allMessages.add(userMsg);
    
    emit(ChatLoaded(List.from(allMessages)));

    try {
      final response = await sendMessageUseCase.call(text);
      
      allMessages.add(response);
      
      emit(ChatLoaded(List.from(allMessages)));
    } catch (e) {
      // 4. هندلة الخطأ
      emit(ChatError(e.toString()));
      
      // بنرجع الحالة لـ Loaded عشان الشات ميفضلش واقف على الـ Error والرسائل القديمة تفضل ظاهرة
      emit(ChatLoaded(List.from(allMessages)));
    }
  }
}