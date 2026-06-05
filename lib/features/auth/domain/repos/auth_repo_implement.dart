import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/error_handling.dart';
import 'package:rafiq/core/networking/api_consumer.dart'; 
import 'package:rafiq/features/auth/data/repos/sign_up_model.dart';
import 'package:rafiq/features/auth/data/repos/user_model.dart';
import 'package:rafiq/features/auth/domain/entities/sign_up_entity.dart';
import 'package:rafiq/features/auth/domain/entities/user_entity.dart';
import 'package:rafiq/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiConsumer apiConsumer; 

  AuthRepoImpl({required this.apiConsumer});

@override
Future<UserEntity> login(String email, String password) async {
  try {
    final formData = FormData.fromMap({
      "username": email,
      "password": password,
    });

    final response = await apiConsumer.post(
      "auth/login",
      data: formData, 
    );
    
    return UserEntity(
      name: email.split('@')[0], 
      email: email, 
      token: response['access_token'], 
    );
  } on ServerException catch (e) {
    throw Exception(e.errMessage);
  } catch (e) {
    throw Exception("بيانات الدخول غير صحيحة، تأكد من البيانات");
  }
}
@override
Future<UserEntity> signup(SignupRequestEntity request) async {
  try {
    final signupModel = SignupModel.fromEntity(request);
    final response = await apiConsumer.post(
      "auth/signup",
      data: signupModel.toJson(request.password),
    );
    
    return UserEntity(
      name: response['full_name'], 
      email: response['email'], 
      token: response['access_token'], 
    ); 
  } on ServerException catch (e) {
    throw Exception(e.errMessage);
  } catch (e) {
    throw Exception("حدث خطأ أثناء قراءة بيانات الحساب الجديد");
  }
}
@override
  Future<void> forgetPassword(String phone) async {
    try {
      await apiConsumer.post(
        "auth/forget-password",
        data: {
          "phone_number": phone, 
        },
      );
    } on ServerException catch (e) {
      throw Exception(e.errMessage);
    } catch (e) {
      throw Exception("فشل إرسال رمز التحقق، تأكد من الرقم");
    }
  }

@override
Future<String> verifyOtp(String phone, String otp) async { // 👈 غيرناها لـ Future<String>
  try {
    final response = await apiConsumer.post(
      "auth/verify-otp",
      data: {
        "phone_number": phone,
        "otp": otp,
      },
    );
    
    return response['access_token']; 
  } on ServerException catch (e) {
    throw Exception(e.errMessage);
  } catch (e) {
    throw Exception("رمز التحقق غير صحيح");
  }
}
  @override
  Future<void> resetPassword({required String token, required String newPassword}) async {
    try {
      await apiConsumer.post(
        "auth/reset-password",
        data: {
          "token": token, 
          "new_password": newPassword, 
        },
      );
    } on ServerException catch (e) {
      throw Exception(e.errMessage);
    } catch (e) {
      throw Exception("فشل إعادة تعيين كلمة المرور");
    }
  }


}