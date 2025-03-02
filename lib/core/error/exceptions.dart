// //date
import '../constant/strings.dart';
//
// class ServerException implements Exception {}
//
// class CacheException implements Exception {}
//
//
// //route
// class RouteException implements Exception {
//   final String message;
//   const RouteException(this.message);
// }

class AppException implements Exception {
  final String? _message;

  AppException([this._message]);

  @override
  String toString() {
    return _message ?? kSomethingWentWrongMSG;
  }
}

class NoInternetException extends AppException {
  NoInternetException([String? msg]) : super(msg);
}

class RouteException extends AppException {
  RouteException([String? msg]) : super(msg);
}

class ServerException extends AppException {
  ServerException([String? msg]) : super(msg);
}
