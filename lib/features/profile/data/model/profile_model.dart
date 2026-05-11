import 'package:rafiq/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.age,
    required super.status,
    required super.childrenCount,
    required super.bio,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      age: json['age'],
      status: json['status'],
      childrenCount: json['children_count'],
      bio: json['bio'] ?? "Parenting Enthusiast",
    );
  }
}