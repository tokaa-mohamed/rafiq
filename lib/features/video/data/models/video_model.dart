import '../../domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.thumbnailUrl,
    required super.videoUrl,
    required super.duration,
    required super.views,
    required super.likes,
    super.tag,
    super.relatedVideos,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      videoUrl: json['video_url'] ?? '',       
      duration: json['duration'] ?? '',
      views: json['views_count']?.toString() ?? '0', 
      likes: json['likes_count']?.toString() ?? '0', 
      tag: json['category_id']?.toString() ?? '',   
      
      relatedVideos: json['related_videos'] != null
          ? (json['related_videos'] as List)
              .map((videoJson) => VideoModel.fromJson(videoJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'thumbnail_url': thumbnailUrl,
      'video_url': videoUrl,
      'duration': duration,
      'views_count': int.tryParse(views) ?? 0,
      'likes_count': int.tryParse(likes) ?? 0,
    };
  }
}