import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/features/Posts/models/comments.model.dart';
import 'package:rafiq/features/Posts/peresentation/comments_view.dart';
class RafiqPostCard extends StatelessWidget {
  const RafiqPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
CircleAvatar(
  radius: 20.r, 
  backgroundColor: Colors.transparent, 
  backgroundImage: const AssetImage("assets/images/daii.png"), 
),              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               const   Text("Rafiq", style: AppTextStyles.extrabold16cairo),
                  Text("2 hours ago • Parenting Specialist", style: AppTextStyles.regular16cairo.copyWith(color: Colors.grey)),
                ],
              ),
            ],
          ),
          16.verticalSpace,
          Text(
            "Active listening is more than just hearing words. It's about understanding the emotion behind them...",
            style: AppTextStyles.regular14cairo.copyWith(height: 1.5),
          ),
          20.verticalSpace,
          Row(
            children: [
              Icon(Icons.favorite_border, size: 20.sp, color: Colors.grey),
              4.horizontalSpace,
              Text("89", style: TextStyle(color: Colors.grey)),
              16.horizontalSpace,
IconButton(
  onPressed: () {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.transparent, 
      builder: (context) => CommentsView(
        comments: [
          CommentEntity(
            userName: "Toka Mohamed",
            text: "Interesting perspective, I hadn't thought of it that way. Could you elaborate more on the second point?",
            timeAgo: "1h ago",
            userImage: "assets/images/friend-comment.png",
            likesCount: 3,
            canDelete: true,
          ),
        ],
      ),
    );
  },
  icon: const Icon(Icons.comment_outlined),
),
              Text("12", style: TextStyle(color: Colors.grey)),
              const Spacer(),
              Icon(Icons.share_outlined, size: 20.sp, color: Colors.grey),
              4.horizontalSpace,
              Text("Share", style: TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}