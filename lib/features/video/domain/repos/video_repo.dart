import 'package:rafiq/features/video/domain/entities/video_category_entity.dart';
import 'package:rafiq/features/video/domain/entities/video_entity.dart';


abstract class VideoRepo {
  Future<List<VideoCategoryEntity>> getCategories();
  Future<List<VideoEntity>> getVideosByStage(String stageId);
  
  Future<VideoEntity> getVideoDetails(String videoId);
  Future<void> addVideo(VideoEntity video);
  Future<void> deleteVideo(String videoId); 
}