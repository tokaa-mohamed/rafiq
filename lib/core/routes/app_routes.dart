import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:rafiq/core/di/dependency_injection.dart';
import 'package:rafiq/features/auth/logic/signup_cubit.dart';
import 'package:rafiq/features/auth/persentation/create_new_password.dart';
import 'package:rafiq/features/auth/persentation/forget_password.dart';
import 'package:rafiq/features/auth/persentation/forget_password.dart';
import 'package:rafiq/features/auth/persentation/otp_view.dart';
import 'package:rafiq/features/auth/persentation/profile_view.dart';
import 'package:rafiq/features/auth/persentation/signin_screen.dart';
import 'package:rafiq/features/auth/persentation/signup_screen.dart';
import 'package:rafiq/features/auth/persentation/success_confirmation_views.dart';
import 'package:rafiq/features/auth/persentation/welcome_screen.dart';
import 'package:rafiq/features/splash_screen/persentation/screens/splash_screen.dart';


abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kLoginView = '/loginView';
  static const welcome = '/welcome';
  static const signUp ='/signup';
  static const signIn ='/signin';
  static const forgetPassword ='/ForgetPasswordView';
  static const otpView ='/otpView';
  static const createNewPasswordView ='/createNewPasswordView';
  static const successConfirmationView ='/successConfirmationView';
  static const profileView ='/profileView';


  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: forgetPassword,
        builder: (context, state) => const ForgetPasswordView(),
      ),
            GoRoute(
        path: otpView,
        builder: (context, state) => const OtpView(),
      ),
            GoRoute(
        path: createNewPasswordView,
        builder: (context, state) => const CreateNewPasswordView(),
      ),
                 GoRoute(
        path: successConfirmationView,
        builder: (context, state) => const SuccessConfirmationView(),
      ),
                 GoRoute(
        path: profileView,
        builder: (context, state) => const ProfileView(),
      ),




            GoRoute(
        path: welcome,
        builder: (context, state) => const   WelcomeView(),
      ),

            GoRoute(
        path: signIn,
        builder: (context, state) => const   LoginScreen(),
      ),


GoRoute(
  path: signUp,
  builder: (context, state) =>  const SignupScreen(),
  
),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Home'))),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Login'))),
      ),
    ],
  );
}