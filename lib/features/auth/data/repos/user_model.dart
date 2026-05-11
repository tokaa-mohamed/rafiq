import 'package:rafiq/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.token, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(token: json['token'], name: json['username'], email: json['email']);
  }
}