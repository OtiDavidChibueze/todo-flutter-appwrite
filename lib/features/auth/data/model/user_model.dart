import 'dart:convert';

import '../../domain/entities/user_entiry.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.lastname,
    required super.firstname,
    required super.email,
    required super.profileImage,
  });

  UserModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? profileImage,
  }) {
    return UserModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map['firstname'] == null ||
        map['lastname'] == null ||
        map['email'] == null ||
        map['profileImage'] == null) {
      throw FormatException('Missing required user fields: $map');
    }

    return UserModel(
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
      profileImage: map['profileImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(firstname: $firstname, lastname: $lastname, email: $email, profileImage: $profileImage)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.firstname == firstname &&
        other.lastname == lastname &&
        other.email == email &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return firstname.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        profileImage.hashCode;
  }
}
