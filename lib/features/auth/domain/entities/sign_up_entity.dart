class SignupRequestEntity {
  final String fullName;
  final String phone;
  final String password;

  SignupRequestEntity({
    required this.fullName, 
    required this.phone, 
    required this.password,
  });
}