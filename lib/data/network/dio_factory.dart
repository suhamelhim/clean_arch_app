

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mena1/app/app_refs.dart';
import 'package:mena1/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String DEFAULT_LANGUAGE="language";
const String APPLICTION_JSON="application/json";
const String CNTENT_TYPE ="content_type";
const String ACCEPT="accept";
const String AUTHRORIZATION="authorization";
class DioFactory {
 final AppPreferences _appPreferences;

 DioFactory(this._appPreferences);

  Future<Dio> getDio() async{
    Dio dio=Dio();

String language= await _appPreferences.getAppLanguage();
    Map<String,String> headers={
      CNTENT_TYPE:APPLICTION_JSON,
      ACCEPT:APPLICTION_JSON,
      AUTHRORIZATION:Constants.token,
      DEFAULT_LANGUAGE:language
    };
if (!kReleaseMode){
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: true
  ));
}
    dio.options=BaseOptions(
      baseUrl: Constants.baseUrl,
  headers: headers,
  receiveTimeout: Constants.apiTimeOut,
  sendTimeout: Constants.apiTimeOut
      );
    return dio;
}
}