
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/entities/chat_entity.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/Assessment_into.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/chatbot_cubit.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/chatbot_states.dart';
class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.babypink,
      appBar: AppBar(
        title:  Text("Rafiq AI", style: AppTextStyles.bold24cairo.copyWith(color: AppColors.darkblack)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.more_vert, color: Colors.black), onPressed: () {})],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Column(
            children: [
           const   SizedBox(height: 20,),
              Expanded(
                child: state is ChatInitial 
                    ? _buildWelcomeView(context) 
                    : _buildChatConversation(state), 
              ),
              _buildMessageInput(context),
            ],
          );
        },
      ),
    );
  }

  // الـ UI بتاع الصورة الأولى (الاقتراحات)
  Widget _buildWelcomeView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
           CircleAvatar(
            radius: 65,
backgroundColor: AppColors.lightYellow.withOpacity(0.2),

            child: const Icon(Icons.smart_toy, size: 70, color: AppColors.lightYellow),
          ),
          const SizedBox(height: 30),
           Text("How can I help you today?", 
style: AppTextStyles.bold24cairo.copyWith(color: AppColors.darkblack)),
          const SizedBox(height: 40),
          _suggestionCard(context, "Parenting Advice"),
          _suggestionCard(context, "Relationship Help"),
          const SizedBox(height: 20),
CustomButton(
  text: 'Start Assessment',
  textColor: Colors.white,
textstyle: AppTextStyles.bold16cairo,
  height: 50, 
  width: 298,
  borderRadius: 10, 
  onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const AssessmentIntroPage()));
  },
),           ],
      ),
    );
  }

  // الـ UI بتاع الصورة الثانية (فقاعات الشات)
  Widget _buildChatConversation(ChatState state) {
    if (state is ChatLoaded) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.messages.length,
        itemBuilder: (context, index) => _buildChatBubble(state.messages[index]),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildChatBubble(ChatMessage msg) {
    return Align(
      alignment: msg.isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: msg.isBot ? Colors.white : AppColors.lightYellow,
          borderRadius: BorderRadius.circular(15).copyWith(
            bottomLeft: msg.isBot ? Radius.zero : const Radius.circular(15),
            bottomRight: msg.isBot ? const Radius.circular(15) : Radius.zero,
          ),
        ),
        child: Text(msg.text, style: AppTextStyles.regular12inter.copyWith(color:msg.isBot ? Colors.black87 : Colors.white ) ,),
      ),
    );
  }

  Widget _suggestionCard(BuildContext context, String title) {
    return GestureDetector(
      onTap: () => context.read<ChatBloc>().sendMessage(title),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.bold16cairo.copyWith(color: AppColors.black2)),
            const Icon(Icons.arrow_forward_ios, size: 10, color:AppColors.lightYellow),
          ],
        ),
      ),
    );
  }

Widget _buildMessageInput(BuildContext context) {
  final controller = TextEditingController();
  
  return Container(
    padding: EdgeInsets.all(15.h),
    child: Row(
      children: [
        // 1. أيقونة الطفل (Double Container)
        Container(
          padding: EdgeInsets.all(8.w), // الطبقة الخارجية (الأغمق)
          decoration:  BoxDecoration(
            color: AppColors.lightYellow.withOpacity(0.2), 
            shape: BoxShape.circle,
          ),
          child: Container(
            padding: EdgeInsets.all(8.w), // الطبقة الداخلية (الأفتح)
            decoration:  BoxDecoration(
              color: AppColors.lightYellow.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.face, color: Color(0xFF96A53A)),
          ),
        ),
        SizedBox(width: 10.w),
        
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Ask anything...",
              hintStyle: AppTextStyles.regular14merr.copyWith(color: AppColors.grey7),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: AppColors.lightYellow, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: AppColors.primaryNormal, width: 2),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.all(8.w),
                child: GestureDetector(
                  onTap: () => context.read<ChatBloc>().sendMessage(controller.text),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.lightYellow,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: const Icon(Icons.send, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}