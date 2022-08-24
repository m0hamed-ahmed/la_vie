import 'package:la_vie/domain/entities/forum_comments.dart';
import 'package:la_vie/domain/entities/forum_likes.dart';
import 'package:la_vie/domain/entities/forum_user.dart';

class DiscussionForum {
  final String forumId;
  final String title;
  final String description;
  final String? imageUrl;
  final String userId;
  final List<ForumLikes> forumLikes;
  final List<ForumComments> forumComments;
  final ForumUser forumUser;

  DiscussionForum({
    required this.forumId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.userId,
    required this.forumLikes,
    required this.forumComments,
    required this.forumUser,
  });
}