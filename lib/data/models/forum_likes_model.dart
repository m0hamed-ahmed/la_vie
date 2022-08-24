import 'package:la_vie/domain/entities/forum_likes.dart';

class ForumLikesModel extends ForumLikes {

  ForumLikesModel({
    required super.forumId,
    required super.userId,
  });

  factory ForumLikesModel.fromJson(Map<String, dynamic> json) {
    return ForumLikesModel(
      forumId: json['forumId'],
      userId: json['userId'],
    );
  }
}