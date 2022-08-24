import 'package:la_vie/domain/entities/forum_comments.dart';

class ForumCommentsModel extends ForumComments {

  ForumCommentsModel({
    required super.forumCommentId,
    required super.forumId,
    required super.userId,
    required super.comment,
    required super.createdAt,
  });

  factory ForumCommentsModel.fromJson(Map<String, dynamic> json) {
    return ForumCommentsModel(
      forumCommentId: json['forumCommentId'],
      forumId: json['forumId'],
      userId: json['userId'],
      comment: json['comment'],
      createdAt: json['createdAt'],
    );
  }
}