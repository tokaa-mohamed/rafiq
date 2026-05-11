import 'dart:io';
import 'package:flutter/foundation.dart'; // عشان kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/core/routes/app_routes.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rafiq/features/reels/widgets/reels_user_info.dart';
import 'package:rafiq/features/reels/widgets/reels_slider.dart'; // تأكدي من اسم الودجت عندك

class ReelsView extends StatefulWidget {
  final bool isAdmin;
  final XFile? videoFile;

  const ReelsView({super.key, this.isAdmin = false, this.videoFile});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoFile != null) {
      _initVideo();
    }
  }

  void _initVideo() {
    // لو ويب بنستخدم networkUrl ولو موبايل بنستخدم file
    if (kIsWeb) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoFile!.path));
    } else {
      _controller = VideoPlayerController.file(File(widget.videoFile!.path));
    }

    _controller!.initialize().then((_) {
      setState(() {});
      _controller!.setLooping(true);
      _controller!.play();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // لو في فيديو شغال اعرضه، لو مفيش اعرض الصورة الـ Mock
         if( _controller != null && _controller!.value.isInitialized)
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                )
          ,
          //  Image.asset(
          //         'assets/images/reels_mock_bg.png',
          //         width: double.infinity,
          //         height: double.infinity,
          //         fit: BoxFit.cover,
          //       ),

          _buildTransparentHeader(context),

          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  child: ReelsUserInfo(
                    userName: "Rafiq",
                    description: "This is your newly published reel!",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: ReelsSidebarActions(
                    isAdmin: widget.isAdmin,
                    onLike: () {},
                    onComment: () {
                      // كود الـ Comment اللي عندك
                    },
                    onShare: () {},
                    onAdminAction: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransparentHeader(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      left: 16.w,
      right: 16.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 28.sp),
          ),
          Text(
            "Reels",
            style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              context.push(        AppRouter.uploadMediaView,
);
            },
            icon: Icon(Icons.add, color: Colors.white, size: 28.sp),
          ),
        ],
      ),
    );
  }
}