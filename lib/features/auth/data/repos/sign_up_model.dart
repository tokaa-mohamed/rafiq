import 'package:rafiq/features/auth/domain/entities/sign_up_entity.dart';

class SignupModel {
  static Map<String, dynamic> toJson(SignupRequestEntity entity) {
    return {
      "full_name": entity.fullName,
      "phone": entity.phone,
      "password": entity.password,
    
    };
  }
}