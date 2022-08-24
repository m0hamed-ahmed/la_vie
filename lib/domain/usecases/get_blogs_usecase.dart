import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/domain/entities/blog.dart';
import 'package:la_vie/domain/repository/base_repository.dart';

class GetBlogsUsecase {
  final BaseRepository baseRepository;

  GetBlogsUsecase(this.baseRepository);

  Future<Either<Failure, Blog>> execute() async {
    return await baseRepository.getBlogs();
  }
}