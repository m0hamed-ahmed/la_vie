import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/domain/entities/plant.dart';
import 'package:la_vie/domain/repository/base_repository.dart';

class GetPlantsUsecase {
  final BaseRepository baseRepository;

  GetPlantsUsecase(this.baseRepository);

  Future<Either<Failure, List<Plant>>> execute() async {
    return await baseRepository.getPlants();
  }
}