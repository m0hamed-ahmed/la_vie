import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/domain/entities/blog.dart';
import 'package:la_vie/domain/entities/discussion_forum.dart';
import 'package:la_vie/domain/entities/forum.dart';
import 'package:la_vie/domain/entities/plant.dart';
import 'package:la_vie/domain/entities/seed.dart';
import 'package:la_vie/domain/entities/tool.dart';
import 'package:la_vie/domain/entities/user.dart';

abstract class BaseRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String firstName, String lastName, String email, String password);
  Future<Either<Failure, User>> updateUser(String firstName, String lastName, String email, String? address);
  Future<Either<Failure, List<Plant>>> getPlants();
  Future<Either<Failure, List<Seed>>> getSeeds();
  Future<Either<Failure, List<Tool>>> getTools();
  Future<Either<Failure, List<DiscussionForum>>> getDiscussionForums();
  Future<Either<Failure, Forum>> createForumPost(String title, String description, String imageBase64);
  Future<Either<Failure, Blog>> getBlogs();
}