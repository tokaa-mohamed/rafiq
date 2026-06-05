class SignupRequestEntity {
  final String fullName;
  final String email; 
  final String phone;
  final String password;

  SignupRequestEntity({
    required this.fullName, 
    required this.email, 
    required this.phone, 
    required this.password,
  });
}