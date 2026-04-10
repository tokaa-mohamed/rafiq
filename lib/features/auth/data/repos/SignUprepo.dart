class SignupRepo {
  Future<void> signup(Map<String, dynamic> userData) async {
    await Future.delayed(const Duration(seconds: 2)); // محاكاة API
  }
}