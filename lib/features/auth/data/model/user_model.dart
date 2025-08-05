import 'dart:convert';

import 'package:todo_flutter_appwrite/features/auth/domain/entities/user_entiry.dart';

class UserModel extends UserEntiry {
  UserModel({
    required super.lastname,
    required super.id,
    required super.firstname,
    required super.email,
    required super.password,
    required super.profileImage,
  });

  UserModel copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? password,
    String? profileImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
      profileImage: profileImage ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map['id'] == null ||
        map['firstname'] == null ||
        map['lastname'] == null ||
        map['email'] == null ||
        map['password'] == null ||
        map['profileImage'] == null) {
      throw FormatException('Missing required user fields: $map');
    }

    return UserModel(
      id: map['id'] as String,
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profileImage: map['profileImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, firstname: $firstname, lastname: $lastname, email: $email, password: $password, profileImage: $profileImage)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.email == email &&
        other.password == password &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        password.hashCode ^
        profileImage.hashCode;
  }
}
