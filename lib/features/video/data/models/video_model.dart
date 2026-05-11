
import 'package:rafiq/features/video/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required super.id, required super.title, required super.description,
    required super.thumbnailUrl, required super.videoUrl, required super.duration,
    required super.views, required super.likes, super.tag, super.relatedVideos,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnail'],
      videoUrl: json['url'],
      duration: json['duration'],
      views: json['views_count'],
      likes: json['likes_count'],
      tag: json['category_tag'] ?? "",
    );
  }
}