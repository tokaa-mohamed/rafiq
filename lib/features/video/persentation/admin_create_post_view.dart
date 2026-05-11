import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/features/video/domain/entities/video_entity.dart';
import 'package:rafiq/features/video/persentation/logic/admin_video_cubit.dart';
import 'package:rafiq/features/video/persentation/logic/admin_video_state.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: BlocListener<AdminVideoCubit, AdminVideoState>(
        listener: (context, state) {
          if (state is AddVideoSuccess) {
            Navigator.pop(context); // الرجوع لقائمة الأدمن بعد النجاح
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. معاينة الميديا (الفيديو المختارة)
              _buildMediaPreview(),
              
              24.verticalSpace,
              
              // 2. خانة العنوان
              _buildLabel("Title"),
              _buildTextField(_titleController, "Give your post a name..."),
              
              20.verticalSpace,
              
              // 3. خانة الوصف
              _buildLabel("Description"),
              _buildTextField(_descController, "Share insights and tips...", maxLines: 5),
              
              24.verticalSpace,
              
              // 4. الإضافات (Location & Tags)
              _buildActionRow(Icons.location_on_outlined, "Add Location"),
              16.verticalSpace,
              _buildActionRow(Icons.local_offer_outlined, "Add Tags"),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: const Text("Create Post", style: TextStyle(color: Colors.black)),
      actions: [
        TextButton(
          onPressed: () => _submitPost(),
          child: Text(
            "Post",
            style: AppTextStyles.bold16cairo.copyWith(color: const Color(0xFFC4D35D)),
          ),
        )
      ],
    );
  }

  void _submitPost() {
    final newPost = VideoEntity(
      id: DateTime.now().toString(),
      title: _titleController.text,
      description: _descController.text,
      videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4", // Mock
      thumbnailUrl: "assets/images/admin_placeholder.png",
      duration: "05:00",
      views: "0",
      likes: "0",
      tag: "Parenting",
    );

    context.read<AdminVideoCubit>().addNewVideo(newPost);
  }

  // --- Widgets مساعدة بناءً على التصميم ---

  Widget _buildMediaPreview() {
    return Container(
      height: 220.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(16.r),
        image: const DecorationImage(
          image: AssetImage("assets/images/admin_preview.png"), // الصورة من التصميم
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // أيقونة التعديل
          Positioned(
            right: 12.w,
            bottom: 12.h,
            child: _buildCircleIcon(Icons.edit, Colors.black87),
          ),
          // أيقونة المسح
          Positioned(
            right: 12.w,
            top: 12.h,
            child: _buildCircleIcon(Icons.close, Colors.black45),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC4D35D))),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(text, style: AppTextStyles.bold16cairo);

  Widget _buildActionRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFC4D35D), size: 22.sp),
        12.horizontalSpace,
        Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildCircleIcon(IconData icon, Color bg) => CircleAvatar(
        radius: 16.r,
        backgroundColor: bg,
        child: Icon(icon, size: 16.sp, color: Colors.white),
      );
}