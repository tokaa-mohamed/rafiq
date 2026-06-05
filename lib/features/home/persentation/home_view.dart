import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/features/home/widgets/admin_create_post.dart';
import 'package:rafiq/features/home/widgets/category_item.dart';
import 'package:rafiq/features/home/widgets/custom_bottom_navbar.dart';
import 'package:rafiq/features/home/widgets/rafiq_card.dart';


// حولناها لـ StatefulWidget
class HomeView extends StatefulWidget {
  final  bool  isAdmin;

  const HomeView({super.key,this.isAdmin=false});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
   final PageController _pageController = PageController(viewportFraction: 0.85);
 int _currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFBF6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              const Text("Learn Today", style: AppTextStyles.bold20cairo),
              16.verticalSpace,

SizedBox(
  height: 200.h, 
  child: PageView.builder(
    controller: _pageController,
    itemCount: 5, 
    onPageChanged: (int index) {
      setState(() {
        _currentPage = index; 
      });
    },
    itemBuilder: (context, index) {
      bool isActive = index == _currentPage;

      return AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w, 
          vertical: isActive ? 0 : 12.h, 
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/family_pic.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isActive ? 1.0 : 0.0, // لو مش نشطة بتبقى شفافة تماماً
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2), // درجة السواد الخفيفة
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
),
           24.verticalSpace,
              const Text("Categories", style: AppTextStyles.bold20cairo),
              16.verticalSpace,
             const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  CategoryItem(title: "Parenting", imagePath: "assets/images/mother_daughter.png"),
                  CategoryItem(title: "Family", imagePath: "assets/images/sons.png"),
                  CategoryItem(title: "Relationships", imagePath: "assets/images/relation.png"),
                ],
              ),
              18.verticalSpace,
              // if (widget.isAdmin) 
              const AdminCreatePostWidget(),
                            24.verticalSpace,

              const RafiqPostCard(),
              20.verticalSpace,
            ],
          ),
        ),
      ),
      // 2. دلوقتي الـ _selectedIndex والـ setState بقوا شغالين صح
      // bottomNavigationBar: CustomBottomNavBar(
      //   currentIndex: _selectedIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      // ),
    );
  }
}