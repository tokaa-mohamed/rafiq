import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/features/Posts/models/comments.model.dart';
import 'package:rafiq/features/Posts/peresentation/comments_view.dart';
class ReelsSidebarActions extends StatelessWidget {
  final bool isAdmin; 
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onAdminAction;

  const ReelsSidebarActions({
    super.key,
    required this.isAdmin,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onAdminAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildActionButton(iconPath:  "assets/images/solar--heart-linear.svg", label:  "5000", onTap: (){}),
        18.verticalSpace,
        _buildActionButton(
  iconPath: "assets/images/solar--chat-round-line-duotone.svg",
  label: "6000",
  onTap: () {
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


), // قفلة الـ buildActionButton
        18.verticalSpace,
        _buildActionButton( iconPath: "assets/images/solar--plain-outline.svg",label: "7000", onTap: (){}),
        18.verticalSpace,
        
        GestureDetector(
          onTap: onAdminAction,
          child: AnimatedSwitcher( 
            duration: const Duration(milliseconds: 300),
            child: isAdmin
                ? Icon(Icons.add_circle_outline, key: const ValueKey("plus"), color: Colors.white, size: 30.sp)
                : CircleAvatar( 
                    key: const ValueKey("logo"),
                    radius: 15.r,
                    backgroundColor: Colors.white,
                    child: const Text("R", style: TextStyle(color: Colors.black)),
                  ),
          ),
        ),
      ],
    );
  }

Widget _buildActionButton({
  required String iconPath, // بنمرر مسار الـ SVG هنا
  required String label,
  required VoidCallback onTap,
  bool isSvg = true, // اختيار لو كنتِ لسه بتستخدمي IconData في حتة تانية
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        onPressed: onTap,
        padding: EdgeInsets.zero, // شيلنا الـ padding عشان الأيقونة تبقى مرتاحة
        constraints: const BoxConstraints(),
        icon: isSvg 
          ? SvgPicture.asset(
              iconPath,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), // تلوين الـ SVG بالأبيض
              width: 28.w,
              height: 28.w,
            )
          : Icon(Icons.favorite, color: Colors.white, size: 28.sp), // اختيار احتياطي
      ),
      4.verticalSpace, // مسافة بسيطة بين الأيقونة والكلمة
      Text(
        label,
        style: TextStyle(
          color: Colors.white, 
          fontSize: 12.sp,
          shadows: [
            Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 4), // عشان الرقم يبان فوق الفيديو
          ],
        ),
      ),
    ],
  );
}
}