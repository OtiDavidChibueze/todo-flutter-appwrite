class UserEntity {
  final String firstname;
  final String lastname;
  final String email;
  final String? password;
  final String profileImage;

  UserEntity({
    required this.firstname,
    required this.lastname,
    required this.email,
    this.password,
    required this.profileImage,
  });
}
