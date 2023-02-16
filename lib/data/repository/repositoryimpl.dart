import 'package:dartz/dartz.dart';
import 'package:mena1/data/data_source/remote_data_source.dart';
import 'package:mena1/data/mapper/mapper.dart';
import 'package:mena1/data/network/error_handler.dart';
import 'package:mena1/data/network/failure.dart';
import 'package:mena1/data/network/networkinfo.dart';
import 'package:mena1/data/network/requests.dart';
import 'package:mena1/domain/models.dart';
import 'package:mena1/domain/repository/repository.dart';

class RepositoryImpl implements Repository{
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if ( await _networkInfo.isConnected){
      try{
        final response= await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());

        }else {
          return Left(Failure(ApiInternalStatus.FAILURE, response.message ?? ResponseMessage.DEFAULT) );
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    }else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }


}