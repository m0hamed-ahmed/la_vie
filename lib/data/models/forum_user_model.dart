import 'package:la_vie/domain/entities/forum_user.dart';

class ForumUserModel extends ForumUser {

  ForumUserModel({
    required super.firstName,
    required super.lastName,
    required super.imageUrl,
  });

  factory ForumUserModel.fromJson(Map<String, dynamic> json) {
    return ForumUserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      imageUrl: json['imageUrl'],
    );
  }
}