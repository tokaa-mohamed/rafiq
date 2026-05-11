import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/features/video/domain/entities/age_statge_entity.dart';
import 'package:rafiq/features/video/persentation/video_list_view.dart';
import 'package:rafiq/features/video/persentation/widgets/ages_stage_card.dart';

class AgeStagesView extends StatelessWidget {
  const AgeStagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AgeStageEntity> stages = [
      AgeStageEntity(
        ageRange: "0-3 YEARS",
        title: "Early Foundation",
        description: "Focus on secure attachment and sensory development.",
        imagePath: "assets/images/0to3.png",
        subTitle: "",
      ),
      AgeStageEntity(
        ageRange: "3-6 YEARS",
        title: "Behavior Control",
        description: "Establishing boundaries and fundamental social skills.",
        imagePath: "assets/images/0to3.png",
        subTitle: "",
      ),

          AgeStageEntity(
        ageRange: "6-9 YEARS",
        title: "Middle Childhood",
        description: "Developing competence and school-age independence.",
        imagePath: "assets/images/0to3.png",
        subTitle: "",
      ),


          AgeStageEntity(
        ageRange: "9-12 YEARS",
        title: "Pre-Adolescence",
        description: "Emotional changes and complex social structures.",
        imagePath: "assets/images/0to3.png",
        subTitle: "",
      ),
                AgeStageEntity(
        ageRange: "12-15 YEARS",
        title: "Early Adolescence",
        description: "Identity formation and navigating peer pressure.",
        imagePath: "assets/images/0to3.png",
        subTitle: "",
      ),
          AgeStageEntity(
        ageRange: "15-18 YEARS",
        title: "Late Adolescence",
        description: "Preparing for autonomy and future planning.",
        imagePath: "assets/images/0to3.png",
        subTitle: "",
      ),


    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Parenting", style: AppTextStyles.bold16cairo.copyWith(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Text(
              "Parenting Age Stages for Rafiq",
              style: AppTextStyles.bold16cairo.copyWith(color: const Color(0xFF1D2633)),
            ),
            8.verticalSpace,
            Text(
              "Guided milestones for every developmental phase.",
              style: AppTextStyles.regular16cairo.copyWith(color: Colors.grey),
            ),
            24.verticalSpace,
            // عرض الكروت
            ListView.builder(
              shrinkWrap: true, 
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stages.length,
              itemBuilder: (context, index) {
                return AgeStageCard(
                  stage: stages[index],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>VideosListView(stageTitle: 'parenting',) )),
                );
              },
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}