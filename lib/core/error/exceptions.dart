
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const AppException(this.message, {this.statusCode, this.data});

  @override
  String toString() => message;
}

/// 400 Bad Request
class BadRequestException extends AppException {
  const BadRequestException([dynamic data])
      : super('Invalid request', statusCode: 400, data: data);
}

/// 401 Unauthorized
class UnauthorizedException extends AppException {
  const UnauthorizedException([dynamic data])
      : super('Authentication failed', statusCode: 401, data: data);
}

/// 403 Forbidden
class ForbiddenException extends AppException {
  const ForbiddenException([dynamic data])
      : super('Access denied', statusCode: 403, data: data);
}

/// 404 Not Found
class NotFoundException extends AppException {
  const NotFoundException([dynamic data])
      : super('Resource not found', statusCode: 404, data: data);
}

/// 500 Internal Server Error
class InternalServerErrorException extends AppException {
  const InternalServerErrorException([dynamic data])
      : super('Server error occurred', statusCode: 500, data: data);
}

/// No Internet Connection
class NoInternetException extends AppException {
  const NoInternetException()
      : super('No internet connection available', statusCode: -1);
}

/// General Server Exception
class ServerException extends AppException {
  const ServerException([String? message, dynamic data])
      : super(message ?? 'Server error occurred', data: data);
}

/// Timeout Exception
class TimeoutException extends AppException {
  const TimeoutException()
      : super('Request timed out', statusCode: -2);
}

/// Custom Exception for API rate limiting
class RateLimitException extends AppException {
  final Duration retryAfter;

  const RateLimitException(this.retryAfter, [dynamic data])
      : super('API rate limit exceeded',
      statusCode: 429,
      data: data);
}