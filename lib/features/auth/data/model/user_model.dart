import '../../domain/entities/user_entiry.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.firstname,
    required super.lastname,
    required super.email,
    required super.profileImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profileImage'] ?? '',
    );
  }
}
