import 'package:dartz/dartz.dart';
import 'package:la_vie/core/error/failure.dart';
import 'package:la_vie/domain/entities/user.dart';
import 'package:la_vie/domain/repository/base_repository.dart';

class LoginUsecase {
  final BaseRepository baseRepository;

  LoginUsecase(this.baseRepository);

  Future<Either<Failure, User>> execute(String email, String password) async {
    return await baseRepository.login(email, password);
  }
}