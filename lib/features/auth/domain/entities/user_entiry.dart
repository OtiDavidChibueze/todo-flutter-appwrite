class UserEntity {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String? profileImage;

  UserEntity({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.profileImage,
  });
}
