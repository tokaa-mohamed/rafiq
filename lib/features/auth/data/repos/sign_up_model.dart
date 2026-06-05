import 'package:rafiq/features/auth/domain/entities/sign_up_entity.dart';

class SignupModel extends SignupRequestEntity {
  SignupModel({
    required super.fullName,
    required super.email,
    required super.phone,
    required super.password,
  });

  Map<String, dynamic> toJson(String confirmPassword) {
    return {
      "full_name": fullName,
      "email": email,
      "phone_number": phone,
      "password": password,
      "confirm_password": confirmPassword,
    };
  }

  factory SignupModel.fromEntity(SignupRequestEntity entity) {
    return SignupModel(
      fullName: entity.fullName,
      email: entity.email,
      phone: entity.phone,
      password: entity.password,
    );
  }
}