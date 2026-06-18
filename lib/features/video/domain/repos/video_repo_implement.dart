import 'package:rafiq/core/networking/api_consumer.dart';
import 'package:rafiq/features/video/data/models/categoryvideo_model.dart';
import 'package:rafiq/features/video/data/models/video_model.dart';
import '../../domain/entities/video_category_entity.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repos/video_repo.dart';

class VideoRepoImpl implements VideoRepo {
  final ApiConsumer api;

  VideoRepoImpl({required this.api});

  @override
  Future<List<VideoCategoryEntity>> getCategories() async {
    final response = await api.get("videos/categories"); // تعديل الباث ليتوافق مع الـ prefix
    List categoriesJson = response as List;
    return categoriesJson.map((json) => VideoCategoryModel.fromJson(json)).toList();
  }

  Future<void> postCategory(VideoCategoryEntity category) async {
    final categoryModel = VideoCategoryModel(
      id: category.id,
      title: category.title,
      description: category.description,
      iconName: category.iconName,
    );
    await api.post("videos/categories", data: categoryModel.toJson());
  }

  @override
  Future<List<VideoEntity>> getVideosByStage(String stageId) async {
    final response = await api.get(
      "videos/list/$stageId",
      queryParameters: {
        "limit": 20,
        "offset": 0,
      },
    );
    List videosJson = response as List;
    return videosJson.map((json) => VideoModel.fromJson(json)).toList();
  }

  @override
  Future<void> addVideo(VideoEntity video) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVideo(String videoId) async {
    await api.delete("videos/$videoId");
  }

  @override
  Future<VideoEntity> getVideoDetails(String videoId) {
    throw UnimplementedError();
  }
}