import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';
import 'package:rafiq/features/reels/persentation/reels_view.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart'; 

class NewReelView extends StatefulWidget {
  final XFile videoFile; 

  const NewReelView({super.key, required this.videoFile});

  @override
  State<NewReelView> createState() => _NewReelViewState();
}

class _NewReelViewState extends State<NewReelView> {
  late VideoPlayerController _videoController;
  bool allowComments = true;
  bool isPublic = true;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoFile.path))
      ..initialize().then((_) {
        setState(() {}); 
        _videoController.setLooping(true);
        _videoController.play(); 
      });
  }

  @override
  void dispose() {
    _videoController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.babypink,
      appBar: AppBar(
        title: const Text("New Reel", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // عرض الفيديو المختار (Preview)
            AspectRatio(
              aspectRatio: 9 / 12,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: _videoController.value.isInitialized
                    ? VideoPlayer(_videoController)
                    : const Center(child: CircularProgressIndicator(color: Color(0xFF96A53A))),
              ),
            ),
            20.verticalSpace,
// Text("Caption",style: AppTextStyles.bold16cairo.copyWith(color: AppColors.grey6),),
            // حقل الـ Caption
                       // 20.verticalSpace,

            TextField(
              decoration: InputDecoration(
                
                hintText: "Write a caption...",
                hintStyle: AppTextStyles.regular18inter.copyWith(color: AppColors.grey6),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r), 
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 3,
            ),
            20.verticalSpace,

// السطر الأول: Allow Comments
buildSettingRow(
  icon: Icons.chat_bubble_outline,
  title: "Allow Comments",
  value: allowComments,
  onChanged: (val) {
    setState(() => allowComments = val);
  },
),

// السطر الثاني: Private/Public
buildSettingRow(
  icon: Icons.public,
  title: "Private/Public",
  value: isPublic,
  onChanged: (val) {
    setState(() => isPublic = val);
  },
),
            
            30.verticalSpace,


                        CustomButton(
              text: 'Publish ',
              onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ReelsView(
        isAdmin: true,
        videoFile: widget.videoFile, 
      ),
    ),
  );
              },
              backgroundColor: AppColors.primaryNormalActive,
              textColor: Colors.white,
              height: 50.h,
            //  icon: const Icon(Icons.edit_note, color: Colors.white),
            ),

          ],
        ),
      ),
    );
  }

Widget buildSettingRow({
  required IconData icon,
  required String title,
  required bool value,
  required Function(bool) onChanged,
}) {
  return Container(
    width: 600.w,
    height: 80.h,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F5F5), 
      borderRadius: BorderRadius.circular(15), 
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(10), 
        ),
        child: Icon(icon, color: Colors.grey[700], size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF96A53A),
      ),
    ),
  );
}


}