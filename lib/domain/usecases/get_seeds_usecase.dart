import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/domain/entities/seed.dart';
import 'package:la_vie/domain/repository/base_repository.dart';

class GetSeedsUsecase {
  final BaseRepository baseRepository;

  GetSeedsUsecase(this.baseRepository);

  Future<Either<Failure, List<Seed>>> execute() async {
    return await baseRepository.getSeeds();
  }
}