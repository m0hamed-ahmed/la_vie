import 'package:la_vie/domain/entities/forum.dart';

class ForumModel extends Forum {

  ForumModel({
    required super.message,
    required super.forumId,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.userId,
  });

  factory ForumModel.fromJson(Map<String, dynamic> json) {
    return ForumModel(
      message: json['message'],
      forumId: json['data']['forumId'],
      title: json['data']['title'],
      description: json['data']['description'],
      imageUrl: json['data']['imageUrl'],
      userId: json['data']['userId'],
    );
  }
}