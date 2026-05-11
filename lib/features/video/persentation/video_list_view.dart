import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/features/video/persentation/video_details_view.dart';
import 'package:rafiq/features/video/persentation/widgets/video_card.dart';
import '../domain/entities/video_entity.dart';

class VideosListView extends StatelessWidget {
  final String stageTitle;
  const VideosListView({super.key, required this.stageTitle});

  @override
  Widget build(BuildContext context) {
    final List<VideoEntity> videos = [
      VideoEntity(
        id: "1",
        title: "The Power of Play",
        description: "Understanding brain development through play.",
        thumbnailUrl: "assets/images/0to3.png",
        videoUrl: "",
        duration: "12:45",
        views: "15k Views",
        likes: "2.4k Likes",
        tag: "Most Watched",
      ),


            VideoEntity(
        id: "2",
        title: "The Power of Play",
        description: "Understanding brain development through play.",
        thumbnailUrl: "assets/images/0to3.png",
        videoUrl: "",
        duration: "12:45",
        views: "15k Views",
        likes: "2.4k Likes",
        tag: "Most Watched",
      ),

    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(title: Text(stageTitle), centerTitle: true, backgroundColor: Colors.white, elevation: 0),
      body: ListView.builder(
        padding: EdgeInsets.all(24.w),
        itemCount: videos.length,
        itemBuilder: (context, index) => VideoCard(
          video: videos[index],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideoDetailsView(video: videos[index]))),
        ),
      ),
    );
  }
}