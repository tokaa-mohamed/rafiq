import 'package:rafiq/features/profile/data/model/profile_model.dart';
import 'package:rafiq/features/profile/domain/entities/profile_entity.dart';
import 'package:rafiq/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {

  @override
  Future<ProfileEntity> getProfileData() async {
    await Future.delayed(const Duration(seconds: 1));
    return ProfileModel(
      firstName: "Ahmed",
      lastName: "Hassan",
      phone: "+1 234 567 890",
      age: 28,
      status: "Married",
      childrenCount: 2,
      bio: "Parenting Enthusiast",
    );
  }
  @override
Future<void> updateProfile(ProfileEntity user) async {
  await Future.delayed(const Duration(seconds: 2)); 
}
}