import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/di/dependency_injection.dart';
import 'package:rafiq/core/networking/notification_service.dart';
import 'package:rafiq/core/routes/app_routes.dart';
import 'package:rafiq/firebase_options.dart';
import 'dart:developer' as developer;

void main()async {
WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); 

  NotificationService notificationService = NotificationService();
  await notificationService.initNotifications();

  

  FirebaseMessaging.onMessage.listen((message) {
    notificationService.showLocalNotification(message);
    developer.log("🔥 RECEIVED IN FOREGROUND");
    developer.log("Title: ${message.notification?.title}");
    developer.log("Body: ${message.notification?.body}");
  });
  
   setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
@override
Widget build(BuildContext context) {
return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          theme: ThemeData.light(useMaterial3: true), 
        );
      },
    );
      }
  }

