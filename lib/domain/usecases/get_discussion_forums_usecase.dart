import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/domain/entities/discussion_forum.dart';
import 'package:la_vie/domain/repository/base_repository.dart';

class GetDiscussionForumsUsecase {
  final BaseRepository baseRepository;

  GetDiscussionForumsUsecase(this.baseRepository);

  Future<Either<Failure, List<DiscussionForum>>> execute() async {
    return await baseRepository.getDiscussionForums();
  }
}