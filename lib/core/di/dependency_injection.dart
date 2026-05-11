import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rafiq/core/networking/api_consumer.dart';
import 'package:rafiq/core/networking/dio_consumer.dart';
import 'package:rafiq/features/auth/domain/repos/auth_repo.dart';
import 'package:rafiq/features/auth/domain/repos/auth_repo_implement.dart';
import 'package:rafiq/features/auth/persentation/logic/forget_pass_cubit.dart';
import 'package:rafiq/features/auth/persentation/logic/signin_cubit.dart';
import 'package:rafiq/features/auth/persentation/logic/signup_cubit.dart';
// تأكدي من مسار الـ LoginCubit الصحيح في مشروعك
import 'package:rafiq/features/chatbot_and_assessment/data/datasource/dataresourceremote.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/repos/assessment_repo.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/repos/assessment_repo_impl.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/repos/chat_repo.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/repos/chat_repo_impl.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/use_cases/get_assessment.dart';
import 'package:rafiq/features/chatbot_and_assessment/domain/use_cases/send_message_usecase.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/assess_cubit.dart';
import 'package:rafiq/features/chatbot_and_assessment/persentation/screens/logic/chatbot_cubit.dart';
import 'package:rafiq/features/profile/domain/repos/profile_repo.dart';
import 'package:rafiq/features/profile/domain/repos/profile_repo_implement.dart';
import 'package:rafiq/features/profile/persentation/logic/profile_cubit.dart';
import 'package:rafiq/features/video/domain/repos/video_repo.dart';
import 'package:rafiq/features/video/domain/repos/video_repo_implement.dart';
import 'package:rafiq/features/video/persentation/logic/video_card_cubit.dart';
import 'package:rafiq/features/video/persentation/logic/video_list_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // --- External ---
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt<Dio>()));

  // --- Auth Feature ---
  getIt.registerLazySingleton<AuthRepo>(() => MockAuthRepoImpl());
  getIt.registerFactory(() => LoginCubit(getIt<AuthRepo>())); 
  getIt.registerFactory(() => SignupCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => ForgetPasswordCubit(getIt<AuthRepo>()));

  // --- Profile Feature ---
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl());
  getIt.registerFactory(() => ProfileCubit(getIt<ProfileRepo>()));

  // --- Video Feature ---
  getIt.registerLazySingleton<VideoRepo>(() => VideoRepoImpl());
  getIt.registerFactory(() => CategoryCubit(getIt<VideoRepo>()));
  getIt.registerFactory(() => VideosListCubit(getIt<VideoRepo>()));

  // --- Chatbot Feature ---
  // 1. Data Source
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  // 2. Repository
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: getIt<ChatRemoteDataSource>()),
  );

  // 3. Use Case
  getIt.registerLazySingleton(() => SendMessageUseCase(getIt<ChatRepository>()));

  // 4. Bloc/Cubit
  getIt.registerFactory(() => ChatBloc(getIt<SendMessageUseCase>()));

  // --- Assessment Feature ---
  getIt.registerLazySingleton<AssessmentRepository>(() => AssessmentRepositoryImpl());
  getIt.registerLazySingleton(() => GetAssessmentQuestions(getIt<AssessmentRepository>()));
  getIt.registerFactory(() => AssessmentCubit(getIt<GetAssessmentQuestions>()));
}