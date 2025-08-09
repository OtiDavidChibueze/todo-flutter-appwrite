class RegisterRequestDto {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  RegisterRequestDto({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
    };
  }
}
