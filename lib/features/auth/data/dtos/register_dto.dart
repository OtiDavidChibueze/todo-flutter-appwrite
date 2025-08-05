class RegisterRequestDto {
  final String fullname;
  final String lastname;
  final String email;
  final String password;

  RegisterRequestDto({
    required this.fullname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'lastname': lastname,
      'email': email,
      'password': password,
    };
  }
}
