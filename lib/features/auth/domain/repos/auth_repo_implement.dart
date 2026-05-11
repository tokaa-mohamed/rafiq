import 'package:rafiq/core/errors/error_handling.dart';
import 'package:rafiq/core/networking/Api_consumer.dart';
import 'package:rafiq/features/auth/data/repos/user_model.dart';
import 'package:rafiq/features/auth/domain/entities/sign_up_entity.dart';
import 'package:rafiq/features/auth/domain/entities/user_entity.dart';
import 'package:rafiq/features/auth/domain/repos/auth_repo.dart';

class MockAuthRepoImpl implements AuthRepo {
  @override
  Future<UserEntity> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // بنقلد الـ API
    if (username == "toka" && password == "123456") {
      return UserModel(token: "fake_token", name: "Toka Mohamed", email: 'toka@gmail.com');
    } else {
      throw Exception("Invalid credentials");
    }
  }

  @override
  Future<UserEntity> signup(SignupRequestEntity request) async {
    await Future.delayed(const Duration(seconds: 2));
    
    return UserEntity(name: request.fullName, token: "new_user_token_123", email: '');
  }

  @override
Future<void> forgetPassword(String phone) async {
  await Future.delayed(const Duration(seconds: 2));
}
@override
Future<void> verifyOtp(String phone, String otp) async {
  // حالياً Mock
  await Future.delayed(const Duration(seconds: 2));
  if (otp != "1234") { // كود وهمي للتجربة
    throw ServerException(errMessage: "كود التحقق غير صحيح");
  }
}

@override
Future<void> resetPassword({required String phone, required String newPassword}) async {
  // Mocking the API call
  await Future.delayed(const Duration(seconds: 2));
  // هنا بنكلم الـ apiConsumer.post("auth/reset-password", data: {...});
}
}