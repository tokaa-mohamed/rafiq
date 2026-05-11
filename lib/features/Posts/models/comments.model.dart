class CommentEntity {
  final String userName;
  final String userImage;
  final String text;
  final String timeAgo;
  final int likesCount;
  final bool canDelete;

  CommentEntity({
    required this.userName,
    required this.userImage,
    required this.text,
    required this.timeAgo,
    this.likesCount = 0,
    this.canDelete = false,
  });
}