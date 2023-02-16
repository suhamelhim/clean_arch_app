import 'package:dartz/dartz.dart';
import 'package:mena1/data/network/failure.dart';
import 'package:mena1/domain/models.dart';
import 'package:mena1/domain/repository/repository.dart';
import 'package:mena1/domain/usecase/base_usecase.dart';

import '../../data/network/requests.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute( LoginUseCaseInput input) async {
   return await _repository.login(LoginRequest(input.email,input.password));
  }


  
  
}
class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}