import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/app_comment_field.dart';
import 'package:rafiq/core/widgets/comments_item.dart';
import 'package:rafiq/features/Posts/models/comments.model.dart';

class CommentsView extends StatefulWidget {
  final List<CommentEntity> comments;

  const CommentsView({super.key, required this.comments});

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            // هيدر بسيط بدل الـ AppBar
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                //  const SizedBox(width: 40,height: 20,col), // للموازنة
              //    Text("Comments", style: AppTextStyles.bold16cairo),
                  // IconButton(
                  //   onPressed: () => Navigator.pop(context),
                  //   icon: const Icon(Icons.close),
                  // ),
                ],
              ),
            ),
         //   const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: widget.comments.length,
                separatorBuilder: (context, index) => Divider(color: Colors.grey.shade100),
                itemBuilder: (context, index) => CommentItem(
                  comment: widget.comments[index],
                  onDelete: () {},
                ),
              ),
            ),
            AppCommentInput(
              controller: _commentController,
              onSend: () {
                if (_commentController.text.trim().isNotEmpty) {
                  print("Sending: ${_commentController.text}");
                  _commentController.clear();
                  FocusScope.of(context).unfocus();
                }
              },
            ),
            10.verticalSpace, // مسافة أمان تحت
          ],
        ),
      ),
    );
  }
}