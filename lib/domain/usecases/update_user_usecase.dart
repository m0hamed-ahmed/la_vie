import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/domain/entities/user.dart';
import 'package:la_vie/domain/repository/base_repository.dart';

class UpdateUserUsecase {
  final BaseRepository baseRepository;

  UpdateUserUsecase(this.baseRepository);

  Future<Either<Failure, User>> execute(String firstName, String lastName, String email, String? address) async {
    return await baseRepository.updateUser(firstName, lastName, email, address);
  }
}