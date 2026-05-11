import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rafiq/core/di/dependency_injection.dart';

// Imports
import 'package:rafiq/features/auth/persentation/logic/signin_cubit.dart';
import 'package:rafiq/features/auth/persentation/signin_screen.dart';
import 'package:rafiq/features/auth/persentation/signup_screen.dart';
import 'package:rafiq/features/auth/persentation/welcome_screen.dart';
import 'package:rafiq/features/auth/persentation/forget_password.dart';
import 'package:rafiq/features/auth/persentation/otp_view.dart';
import 'package:rafiq/features/auth/persentation/create_new_password.dart';
import 'package:rafiq/features/auth/persentation/success_confirmation_views.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/chatbot_screens.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/chatbot_cubit.dart';
import 'package:rafiq/features/home/persentation/home_view.dart';
import 'package:rafiq/features/home/widgets/main_layout.dart';
import 'package:rafiq/features/home/widgets/post_sheet.dart'; 
import 'package:rafiq/features/video/persentation/video_view.dart';
import 'package:rafiq/features/reels/persentation/reels_view.dart';
import 'package:rafiq/features/auth/persentation/profile_view.dart';
import 'package:rafiq/features/profile/domain/entities/profile_entity.dart';
import 'package:rafiq/features/profile/persentation/edit_profile.dart';
import 'package:rafiq/features/video/domain/entities/video_entity.dart';
import 'package:rafiq/features/video/persentation/video_details_view.dart';
import 'package:rafiq/features/video/persentation/video_list_view.dart';
import 'package:rafiq/features/video/persentation/age_stage_view.dart';
import 'package:rafiq/features/video/persentation/admin_video_view.dart';
import 'package:rafiq/features/video/persentation/admin_create_post_view.dart';
import 'package:rafiq/features/reels/persentation/new_reels_view.dart';
import 'package:rafiq/features/reels/persentation/upload_media_view.dart';
import 'package:rafiq/features/Posts/peresentation/comments_view.dart';

abstract class AppRouter {
  static const welcome = '/welcome';
  static const signUp = '/signup';
  static const signIn = '/signin';
  static const forgetPassword = '/ForgetPasswordView';
  static const otpView = '/otpView';
  static const createNewPasswordView = '/createNewPasswordView';
  static const successConfirmationView = '/successConfirmationView';
  
  static const homeView = '/HomeView';
  static const educationalVideosView = '/EducationalVideosView';
  static const reelsView = '/ReelsView';
  static const profileView = '/profileView';
  
  static const editProfileView = '/EditProfileView';
  static const videoDetailsView = '/VideoDetailsView';
  static const videosListView = '/VideosListView';
  static const ageStagesView = '/AgeStagesView';
  static const parentingAdminView = '/ParentingAdminView';
  static const createPostView = '/CreatePostView';
  static const commentsView = '/CommentsView';
  static const newReelView = '/NewReelView';
  static const uploadMediaView = '/UploadMediaView';
  static const createPostSheet = '/CreatePostSheet';
  static const chatPage = '/ChatPage';
  static const bookSessionScreen = '/BookSessionScreen';

  
  

  

  static final router = GoRouter(
    initialLocation: signIn,
    routes: [
      GoRoute(path: welcome, builder: (context, state) => const WelcomeView()),
    //  GoRoute(path: chatPage, builder: (context, state) =>  ChatPage()),

      
      GoRoute(
        path: signIn,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(path: signUp, builder: (context, state) => const SignupScreen()),
      GoRoute(path: forgetPassword, builder: (context, state) => const ForgetPasswordView()),
      GoRoute(path: otpView, builder: (context, state) => const OtpView(phoneNumber: '')),
      GoRoute(path: createNewPasswordView, builder: (context, state) => const CreateNewPasswordView(phoneNumber: '')),
      GoRoute(path: successConfirmationView, builder: (context, state) => const SuccessConfirmationView()),

      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child); 
        },
        routes: [
          GoRoute(path: homeView, builder: (context, state) => const HomeView()),
          GoRoute(path: educationalVideosView, builder: (context, state) => const EducationalVideosView()),
          GoRoute(path: '/ChatPage', builder: (context, state) =>  BlocProvider(
  create: (_) => getIt<ChatBloc>(), 
  child:  ChatPage(),
)),
GoRoute(
  path: reelsView,
  builder: (context, state) {
    // بناخد الـ video من الـ extra لو موجود
    final video = state.extra as XFile?; 
    return ReelsView(
      isAdmin: true, // أو حسب اللوجيك عندك
      videoFile: video,
    );
  },
),          GoRoute(path: profileView, builder: (context, state) => const ProfileView()),
        ],
      ),

      GoRoute(
        path: videoDetailsView,
        builder: (context, state) {
          final videoModel = state.extra as VideoEntity;
          return VideoDetailsView(video: videoModel);
        },
      ),
      GoRoute(
        path: editProfileView,
        builder: (context, state) {
          final profile = ProfileEntity(
            firstName: 'toka', lastName: 'mohamed', childrenCount: 2,
            age: 20, bio: 'hello', phone: '01204', status: 'married',
          );
          return EditProfileView(user: profile);
        },
      ),
      GoRoute(path: ageStagesView, builder: (context, state) => const AgeStagesView()),
      GoRoute(path: videosListView, builder: (context, state) => const VideosListView(stageTitle: '')),
      GoRoute(path: parentingAdminView, builder: (context, state) => const ParentingAdminView()),
      GoRoute(path: createPostView, builder: (context, state) => const CreatePostView()),
      GoRoute(path: commentsView, builder: (context, state) => const CommentsView(comments: [])),
      GoRoute(path: uploadMediaView, builder: (context, state) => const UploadMediaView()),
      GoRoute(path: createPostSheet, builder: (context, state) => const CreatePostSheet()),

      
GoRoute(
  path: newReelView,
  builder: (context, state) {
    final videoFile = state.extra as XFile; // غيري النوع هنا لـ XFile
    return NewReelView(videoFile: videoFile);
  },
),

    ],
  );
}