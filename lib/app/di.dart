import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mena1/app/app_refs.dart';
import 'package:mena1/data/data_source/remote_data_source.dart';
import 'package:mena1/data/network/app_api.dart';
import 'package:mena1/data/network/dio_factory.dart';
import 'package:mena1/data/network/networkinfo.dart';
import 'package:mena1/data/repository/repositoryimpl.dart';
import 'package:mena1/domain/repository/repository.dart';
import 'package:mena1/domain/usecase/login_usecsse.dart';
import 'package:mena1/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance=GetIt.instance;

Future <void> initAppModule  () async  {
  final sharedPrefs=await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(InternetConnectionChecker()));
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  Dio dio =await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImp(instance<AppServiceClient>()));
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance()));
}

 initLoginModule ()  {
  if (!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }

}