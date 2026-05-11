import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // هنا بنضيف الـ Headers اللي السيرفر بيحتاجها دايماً
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept-Language'] = 'ar'; // لو الأبلكيشن بيدعم العربي
    
    
    super.onRequest(options, handler);
  }
}