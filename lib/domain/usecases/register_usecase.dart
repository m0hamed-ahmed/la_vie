import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/domain/entities/user.dart';
import 'package:la_vie/domain/repository/base_repository.dart';

class RegisterUsecase {
  final BaseRepository baseRepository;

  RegisterUsecase(this.baseRepository);

  Future<Either<Failure, User>> execute(String firstName, String lastName, String email, String password) async {
    return await baseRepository.register(firstName, lastName, email, password);
  }
}