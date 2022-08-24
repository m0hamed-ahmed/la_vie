import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/domain/entities/tool.dart';
import 'package:la_vie/domain/repository/base_repository.dart';

class GetToolsUsecase {
  final BaseRepository baseRepository;

  GetToolsUsecase(this.baseRepository);

  Future<Either<Failure, List<Tool>>> execute() async {
    return await baseRepository.getTools();
  }
}