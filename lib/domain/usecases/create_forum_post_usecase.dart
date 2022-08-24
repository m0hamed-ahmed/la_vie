import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/domain/entities/forum.dart';
import 'package:la_vie/domain/repository/base_repository.dart';

class CreateForumPostUsecase {
  final BaseRepository baseRepository;

  CreateForumPostUsecase(this.baseRepository);

  Future<Either<Failure, Forum>> execute(String title, String description, String imageBase64) async {
    return await baseRepository.createForumPost(title, description, imageBase64);
  }
}