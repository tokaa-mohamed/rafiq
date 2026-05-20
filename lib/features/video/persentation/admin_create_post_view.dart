import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/features/video/domain/entities/video_entity.dart';
import 'package:rafiq/features/video/persentation/logic/admin_video_cubit.dart';
import 'package:rafiq/features/video/persentation/logic/admin_video_state.dart';

class CreatePostView extends StatefulWidget {
  final XFile videoFile;

  const CreatePostView({super.key, dynamic videoFile}) : videoFile = videoFile as XFile;

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    final videoUri = Uri.parse(widget.videoFile.path);

    _videoController = VideoPlayerController.networkUrl(videoUri)
      ..initialize().then((_) {
        setState(() {}); // لتحديث الـ UI بعد تهيئة الفيديو
        _videoController?.setLooping(true);
        _videoController?.play(); // تشغيل الفيديو تلقائياً في المعاينة
      }).catchError((error) {
        debugPrint("Video Player Error: $error");
      });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.babypink,
      appBar: _buildAppBar(context),
      body: BlocListener<AdminVideoCubit, AdminVideoState>(
        listener: (context, state) {
          if (state is AddVideoSuccess) {
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMediaPreview(),
              24.verticalSpace,
              _buildLabel("Title"),
        const      SizedBox(height: 10,),
              _buildTextField(_titleController, "Give your post a name..."),
              20.verticalSpace,
              _buildLabel("Description"),
                      const      SizedBox(height: 10,),

              _buildTextField(_descController, "Share insights and tips...", maxLines: 5),
              25.verticalSpace,
              _buildActionRow(Icons.location_on_outlined, "Add Location"),
              25.verticalSpace,
              _buildActionRow(Icons.local_offer_outlined, "Add Tags"),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.babypink,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text("Create Post", style: AppTextStyles.bold24cairo.copyWith(color: AppColors.darkblack)),
      actions: [
        TextButton(
          onPressed: () => _submitPost(),
          child: Text(
            "Post",
            style: AppTextStyles.bold20cairo.copyWith(color: AppColors.primaryNormal),
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
      videoUrl: widget.videoFile.path, // باصينا مسار الفيديو الحقيقي المختار هنا
      thumbnailUrl: "assets/images/admin_placeholder.png", // هنا يمكنكِ توليد thumbnail لاحقاً
      duration: "02:00",
      views: "0",
      likes: "0",
      tag: "Parenting",
    );

    context.read<AdminVideoCubit>().addNewVideo(newPost);
  }

  Widget _buildMediaPreview() {
    return Container(
      height: 220.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            // عرض الفيديو الحقيقي داخل الـ Container مع الحفاظ على الأبعاد وطريقة العرض المريحة للعين
            _videoController != null && _videoController!.value.isInitialized
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoController!.value.size.width,
                        height: _videoController!.value.size.height,
                        child: VideoPlayer(_videoController!),
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator(color: AppColors.primaryNormal)),
            
            // الطبقة العلوية للأيقونات كما هي في التصميم الأصلي
            Positioned(
              right: 12.w,
              bottom: 12.h,
              child: _buildCircleIcon(Icons.edit, Colors.black87),
            ),
            Positioned(
              right: 12.w,
              top: 12.h,
              child: _buildCircleIcon(Icons.close, Colors.black45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: AppTextStyles.regular16cairo.copyWith(color: AppColors.grey10),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.ligthgrey, width: 3.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.ligthgrey, width: 3.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: const Color(0xFFC4D35D), width: 1.5.w),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(text, style: AppTextStyles.bold14cairo.copyWith(color: AppColors.secondaryNormal));

  Widget _buildActionRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryNormal, size: 22.sp),
        12.horizontalSpace,
        Text(text, style: AppTextStyles.regular14cairo.copyWith(color: AppColors.grey10)),
      ],
    );
  }

  Widget _buildCircleIcon(IconData icon, Color bg) => CircleAvatar(
        radius: 16.r,
        backgroundColor: bg,
        child: Icon(icon, size: 16.sp, color: Colors.white),
      );
}