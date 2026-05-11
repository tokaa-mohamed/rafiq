class VideoEntity {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final String duration;
  final String views; 
  final String likes; 
  final String tag;   
  final List<VideoEntity>? relatedVideos; // فيديوهات ذات صلة

  VideoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.duration,
    required this.views,
    required this.likes,
    this.tag = "",
    this.relatedVideos,
  });
}