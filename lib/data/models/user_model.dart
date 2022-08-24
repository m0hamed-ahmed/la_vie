import 'package:la_vie/domain/entities/user.dart';

class UserModel extends User {

  const UserModel({
    required super.message,
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.imageUrl,
    super.address,
    required super.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      userId: json['data']['user']['userId'],
      firstName: json['data']['user']['firstName'],
      lastName: json['data']['user']['lastName'],
      email: json['data']['user']['email'],
      imageUrl: json['data']['user']['imageUrl'],
      address: json['data']['user']['address'],
      accessToken: json['data']['accessToken'],
    );
  }

  factory UserModel.fromJsonWithoutUserKey(Map<String, dynamic> json, String accessToken) {
    return UserModel(
      message: json['message'],
      userId: json['data']['userId'],
      firstName: json['data']['firstName'],
      lastName: json['data']['lastName'],
      email: json['data']['email'],
      imageUrl: json['data']['imageUrl'],
      address: json['data']['address'],
      accessToken: accessToken,
    );
  }

  factory UserModel.fromLocalJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      address: json['address'],
      accessToken: json['accessToken'],
    );
  }

  static Map<String, dynamic> toMap(User user) {
    return {
      'message': user.message,
      'userId': user.userId,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'imageUrl': user.imageUrl,
      'address': user.address,
      'accessToken': user.accessToken,
    };
  }
}