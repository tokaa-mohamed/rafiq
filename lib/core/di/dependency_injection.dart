import 'package:get_it/get_it.dart';
import 'package:rafiq/features/auth/data/repos/SignUprepo.dart';
import 'package:rafiq/features/auth/logic/signup_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo());
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));
}