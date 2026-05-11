import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String errMessage;

  ServerException({required this.errMessage});
}

void handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errMessage: "مهلة الاتصال انتهت، حاول مجدداً");
    case DioExceptionType.sendTimeout:
      throw ServerException(errMessage: "فشل إرسال البيانات، تأكد من الإنترنت");
    case DioExceptionType.receiveTimeout:
      throw ServerException(errMessage: "السيرفر تأخر في الرد");
    case DioExceptionType.badCertificate:
      throw ServerException(errMessage: "مشكلة في شهادة الأمان الخاصة بالسيرفر");
    case DioExceptionType.badResponse:
      _handleResponseError(e.response); // ميثود تانية للتعامل مع الـ Status Codes
      break;
    case DioExceptionType.cancel:
      throw ServerException(errMessage: "تم إلغاء الطلب");
    case DioExceptionType.connectionError:
      throw ServerException(errMessage: "لا يوجد اتصال بالإنترنت");
    case DioExceptionType.unknown:
      throw ServerException(errMessage: "حدث خطأ غير متوقع، حاول لاحقاً");
  }
}

void _handleResponseError(Response? response) {
  if (response == null) {
    throw ServerException(errMessage: "رد السيرفر فارغ");
  }

  switch (response.statusCode) {
    case 400: // Bad Request
      throw ServerException(errMessage: response.data['message'] ?? "بيانات غير صحيحة");
    case 401: // Unauthorized
      throw ServerException(errMessage: "جلسة العمل انتهت، سجل دخول مجدداً");
    case 403: // Forbidden
      throw ServerException(errMessage: "ليس لديك صلاحية للقيام بهذا الإجراء");
    case 404: // Not Found
      throw ServerException(errMessage: "الرابط المطلوب غير موجود");
    case 409: // Conflict
      throw ServerException(errMessage: "هذا الحساب موجود بالفعل");
    case 500: // Internal Server Error
      throw ServerException(errMessage: "مشكلة في السيرفر، جاري العمل على حلها");
    default:
      throw ServerException(errMessage: "عذراً، حدث خطأ ما");
  }
}