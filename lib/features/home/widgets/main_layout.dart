import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/features/home/widgets/custom_bottom_navbar.dart';

class MainLayout extends StatelessWidget {
  final Widget child; // هنا هنستخدم child بدل shell

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // ميثود بتعرفنا إحنا في أنهي Index بناءً على الـ Path الحالي
    int getCurrentIndex(BuildContext context) {
      final String location = GoRouterState.of(context).uri.toString();
      if (location.startsWith('/HomeView')) return 0;
      if (location.startsWith('/EducationalVideosView')) return 1;
      if (location.startsWith('/ChatPage')) return 2;
      if (location.startsWith('/ReelsView')) return 3;
      if (location.startsWith('/profileView')) return 4;
      return 0;
    }

    return Scaffold(
      body: child, // عرض الصفحة الحالية
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: getCurrentIndex(context),
        onTap: (index) {
          switch (index) {
            case 0: context.go('/HomeView'); break;
            case 1: context.go('/EducationalVideosView'); break;
            case 2: context.go('/ChatPage'); break;
            case 3: context.go('/ReelsView'); break;
            case 4: context.go('/profileView'); break;
          }
        },
      ),
    );
  }
}