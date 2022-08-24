import 'dart:convert';

import 'package:la_vie/data/models/forum_comments_model.dart';
import 'package:la_vie/data/models/forum_likes_model.dart';
import 'package:la_vie/data/models/forum_user_model.dart';
import 'package:la_vie/domain/entities/discussion_forum.dart';
import 'package:la_vie/domain/entities/forum_comments.dart';
import 'package:la_vie/domain/entities/forum_likes.dart';

class DiscussionForumModel extends DiscussionForum {

  DiscussionForumModel({
    required super.forumId,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.userId,
    required super.forumLikes,
    required super.forumComments,
    required super.forumUser,
  });

  factory DiscussionForumModel.fromJson(Map<String, dynamic> json) {
    return DiscussionForumModel(
      forumId: json['forumId'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      userId: json['userId'],
      forumLikes: List<ForumLikes>.from(json['ForumLikes'].map((e) => ForumLikesModel.fromJson(e))),
      forumComments: List<ForumComments>.from(json['ForumComments'].map((e) => ForumCommentsModel.fromJson(e))),
      forumUser: ForumUserModel.fromJson(json['user']),
    );
  }
}