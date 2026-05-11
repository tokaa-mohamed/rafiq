import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/profile/domain/entities/profile_entity.dart';
import 'package:rafiq/features/profile/domain/repos/profile_repo.dart';
import 'package:rafiq/features/profile/persentation/logic/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final user = await profileRepo.getProfileData();
      emit(ProfileSuccess(user));
    } catch (e) {
      emit(ProfileError("فشل تحميل بيانات الحساب"));
    }
  }

  Future<void> updateProfile(ProfileEntity user) async {
  emit(UpdateProfileLoading());
  try {
    await profileRepo.updateProfile(user);
    emit(UpdateProfileSuccess());
    getProfile(); 
  } catch (e) {
    emit(UpdateProfileError("فشل تحديث البيانات"));
  }
}
}