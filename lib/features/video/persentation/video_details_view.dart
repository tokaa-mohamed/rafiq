import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import '../domain/entities/video_entity.dart';

class VideoDetailsView extends StatefulWidget {
  final VideoEntity video;
  const VideoDetailsView({super.key, required this.video});

  @override
  State<VideoDetailsView> createState() => _VideoDetailsViewState();
}

class _VideoDetailsViewState extends State<VideoDetailsView> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.videoUrl),
    )..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRealVideoPlayer(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title,
                    style: AppTextStyles.bold16cairo.copyWith(color: Colors.black),
                  ),
                  10.verticalSpace,
                  Text(
                    widget.video.description,
                    style: AppTextStyles.regular14cairo.copyWith(color: Colors.grey[700]),
                  ),
                  
                  24.verticalSpace,
                  
                  _buildStatsRow(),
                  
                  32.verticalSpace,
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Related Videos", style: AppTextStyles.bold16cairo),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View All",
                          style: AppTextStyles.bold16cairo.copyWith(color: const Color(0xFFC4D35D)),
                        ),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  _buildRelatedVideosList(),
                  20.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Video Details",
        style: AppTextStyles.bold16cairo.copyWith(color: Colors.black),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildRealVideoPlayer() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.black,
        child: _isInitialized
            ? Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_controller),
                  _buildPlayPauseOverlay(),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Color(0xFFC4D35D),
                      bufferedColor: Colors.white24,
                      backgroundColor: Colors.white12,
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(color: Color(0xFFC4D35D)),
              ),
      ),
    );
  }

  Widget _buildPlayPauseOverlay() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.value.isPlaying ? _controller.pause() : _controller.play();
        });
      },
      child: Container(
        color: Colors.transparent, 
        child: Center(
          child: CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.black26,
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 40.r,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatItem(Icons.thumb_up_alt_outlined, widget.video.likes),
        20.horizontalSpace,
        _buildStatItem(Icons.visibility_outlined, widget.video.views),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String val) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4E8),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: const Color(0xFF9DB454)),
          8.horizontalSpace,
          Text(
            val,
            style: AppTextStyles.bold16cairo.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedVideosList() {
    return SizedBox(
      height: 160.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.video.relatedVideos?.length ?? 3,
        itemBuilder: (context, index) {
          return Container(
            width: 180.w,
            margin: EdgeInsets.only(right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    "assets/images/6to12.png", // استبدال بصورة الفيديو الحقيقية
                    height: 100.h,
                    width: 180.w,
                    fit: BoxFit.cover,
                  ),
                ),
                8.verticalSpace,
            const    Text(
                  "Related Video Title",
                  style: AppTextStyles.bold16cairo,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}