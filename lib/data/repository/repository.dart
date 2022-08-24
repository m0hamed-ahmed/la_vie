import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/data/data_source/remote_data_source.dart';
import 'package:la_vie/domain/entities/blog.dart';
import 'package:la_vie/domain/entities/discussion_forum.dart';
import 'package:la_vie/domain/entities/forum.dart';
import 'package:la_vie/domain/entities/plant.dart';
import 'package:la_vie/domain/entities/seed.dart';
import 'package:la_vie/domain/entities/tool.dart';
import 'package:la_vie/domain/entities/user.dart';
import 'package:la_vie/domain/repository/base_repository.dart';

class Repository extends BaseRepository {
  final BaseRemoteDataSource baseRemoteDataSource;

  Repository(this.baseRemoteDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      User user = await baseRemoteDataSource.login(email, password);
      return Right(user);
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register(String firstName, String lastName, String email, String password) async {
    try {
      User user = await baseRemoteDataSource.register(firstName, lastName, email, password);
      return Right(user);
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(String firstName, String lastName, String email, String? address) async {
    try {
      User user = await baseRemoteDataSource.updateUser(firstName, lastName, email, address);
      return Right(user);
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Plant>>> getPlants() async {
    try {
      final List<Plant> plants = await baseRemoteDataSource.getPlants();
      return Right(plants);
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Seed>>> getSeeds() async {
    try {
      final List<Seed> seeds = await baseRemoteDataSource.getSeeds();
      return Right(seeds);
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Tool>>> getTools() async {
    try {
      final List<Tool> tools = await baseRemoteDataSource.getTools();
      return Right(tools);
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DiscussionForum>>> getDiscussionForums() async {
    try {
      final List<DiscussionForum> discussionForums = await baseRemoteDataSource.getDiscussionForum();
      return Right(discussionForums);
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Blog>> getBlogs() async {
    try {
      final Blog blog = await baseRemoteDataSource.getBlogs();
      return Right(blog);
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Forum>> createForumPost(String title, String description, String imageBase64) async {
    try {
      final Forum forum = await baseRemoteDataSource.createForumPost(title, description, imageBase64);
      return Right(forum);
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }
}