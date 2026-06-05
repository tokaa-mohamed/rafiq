import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/app_generic_card.dart';
import 'package:rafiq/features/Posts/models/comments.model.dart';
import 'package:rafiq/features/Posts/peresentation/comments_view.dart';
class RafiqPostCard extends StatelessWidget {
  const RafiqPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGenericCard(
      padding: 16.w,
      color: Colors.white,
      borderRadius: 16.r,
      border: Border.all(color: Colors.grey.shade200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(), 
          16.verticalSpace,
          _buildContent(),
          20.verticalSpace,
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: Colors.transparent,
          backgroundImage: const AssetImage("assets/images/daii.png"),
        ),
        12.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Rafiq", style: AppTextStyles.extrabold16cairo),
            Text("2 hours ago • Parenting Specialist", 
                style: AppTextStyles.regular16cairo.copyWith(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Text(
      "Active listening is more than just hearing words. It's about understanding the emotion behind them...",
      style: AppTextStyles.regular14cairo.copyWith(height: 1.5),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.favorite_border, size: 20.sp, color: Colors.grey),
        4.horizontalSpace,
        const Text("89", style: TextStyle(color: Colors.grey)),
        16.horizontalSpace,
        IconButton(
          onPressed: () => _showComments(context),
          icon: const Icon(Icons.comment_outlined),
        ),
        const Text("12", style: TextStyle(color: Colors.grey)),
        const Spacer(),
        Icon(Icons.share_outlined, size: 20.sp, color: Colors.grey),
        4.horizontalSpace,
        const Text("Share", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentsView(
        comments: [
          CommentEntity(
            userName: "Toka Mohamed", //
            text: "Interesting perspective...",
            timeAgo: "1h ago",
            userImage: "assets/images/friend-comment.png",
            likesCount: 3,
            canDelete: true,
          ),
        ],
      ),
    );
  }
}