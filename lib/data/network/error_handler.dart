import 'package:dio/dio.dart';
import 'package:mena1/data/network/failure.dart';

import 'error_handler.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
    } else {
      failure = DataSource.DEFULT.getFailure();
    }
  }
}

Failure _handlerError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIME.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECEIVE_TIME.getFailure();
    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSource.DEFULT.getFailure();
      }

    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSource.DEFULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNET_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIME,
  SEND_TIME,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);

      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);

      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);

      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);

      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIME:
        return Failure(ResponseCode.RECEIVE_TIME, ResponseMessage.RECEIVE_TIME);
      case DataSource.SEND_TIME:
        return Failure(ResponseCode.SEND_TIME, ResponseMessage.SEND_TIME);

    }
    return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
  }
}

class ResponseCode {
  static const int SUCCESS = 200;
  static const int CONNECT_TIMEOUT = 201;
  static const int NO_CONTENT = 200;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 401;
  static const int UNAUTHORISED = 403;
  static const int NOT_FOUND = 500;
  static const int INTERNET_SERVER_ERROR = -1;
  static const int CANCEL = -2;
  static const int RECEIVE_TIME = -3;
  static const int SEND_TIME = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
}

class ResponseMessage {
  static const String SUCCESS = "SUCCESS";
  static const String NO_CONTENT = "SUCCESS";
  static const String BAD_REQUEST = "bad request, try again later";
  static const String FORBIDDEN = "forbidden request";
  static const String UNAUTHORISED = "user is unauthorised , try again later  ";
  static const String NOT_FOUND = "500";
  static const String INTERNET_SERVER_ERROR =
      "something went wrong , try a gain later ";
  static const String CANCEL = "request was canceled ";
  static const String RECEIVE_TIME = "time out error ,tray again later";
  static const String SEND_TIME = "time out error ,tray again later";
  static const String CACHE_ERROR = "cache error ,tray again later";
  static const String NO_INTERNET_CONNECTION =
      "please check tour internet connection";
  static const String DEFAULT = "something wrong ";
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
