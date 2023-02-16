import 'package:mena1/data/network/app_api.dart';
import 'package:mena1/data/network/requests.dart';
import 'package:mena1/data/response/responses.dart';

abstract class RemoteDataSource{

  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}
class RemoteDataSourceImp implements RemoteDataSource{

  final AppServiceClient _appServiceClient;

  RemoteDataSourceImp(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
return await _appServiceClient.login(loginRequest.email, loginRequest.password);
  }


}
