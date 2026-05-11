import 'package:flutter/material.dart';

import '../../domain/entities/video_category_entity.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repos/video_repo.dart';

class VideoRepoImpl implements VideoRepo {
  
  // قائمة Static لتعمل كقاعدة بيانات مؤقتة (Mock Database)
  // هكذا عند الإضافة من شاشة الأدمن، ستتحدث البيانات في شاشة المستخدم تلقائياً
  static List<VideoEntity> _mockVideos = [
    VideoEntity(
      id: "1",
      title: "The Power of Play",
      description: "Understanding brain development through play and early interaction.",
      thumbnailUrl: "assets/images/0to3.png",
      videoUrl: "assets/images/baby-videos.mp4",
      duration: "12:45",
      views: "15k",
      likes: "2.4k",
    ),
    VideoEntity(
      id: "2",
      title: "Nurturing Early Bonds",
      description: "Practical tips for secure attachment and emotional growth during infancy.",
      thumbnailUrl: "assets/images/0to6.png",
      videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
      duration: "08:30",
      views: "10k",
      likes: "1.8k",
    ),
  ];


  @override
  Future<List<VideoCategoryEntity>> getCategories() async {
    // محاكاة تأخير الشبكة
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      VideoCategoryEntity(
        title: "Parenting",
        description: "Guided milestones for every developmental phase.",
        icon: Icons.family_restroom, color: Colors.blue,
      ),
      VideoCategoryEntity(
        title: "Marital Relationship",
        description: "Building healthy communication and bonds.",
        icon: Icons.favorite, color: Colors.red,
      ),


            VideoCategoryEntity(
        title: "Family preparation",
        description: "Building healthy communication and bonds.",
        icon: Icons.home_work_sharp, color: Colors.red,
      ),

    ];
  }

  @override
  Future<List<VideoEntity>> getVideosByStage(String stageId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockVideos;
  }


  @override
  Future<void> addVideo(VideoEntity video) async {
    await Future.delayed(const Duration(seconds: 1));
    _mockVideos.add(video);
  }

  @override
  Future<void> deleteVideo(String videoId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockVideos.removeWhere((video) => video.id == videoId);
  }
  
  @override
  Future<VideoEntity> getVideoDetails(String videoId) {
    // TODO: implement getVideoDetails
    throw UnimplementedError();
  }
}