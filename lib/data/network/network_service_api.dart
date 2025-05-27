import 'dart:convert';
import 'dart:io';
import 'package:client_app/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';
import '../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;

import '../../services/session_manager/session_manager.dart';

class NetworkServiceApi implements BaseApiServices {
  final SessionController _sessionController = SessionController();

  @override
  Future getApi(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final headers = await _getHeaders();
      Uri uri = Uri.parse(url);
      if (queryParameters != null && queryParameters.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParameters);
      }
      final response = await http
          .get(
            uri,
            // Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 30));

      return returnResponse(response);
    } on SocketException {
      throw const NoInternetException();
    } on TimeoutException {
      throw const TimeoutException();
    } on http.ClientException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future postApi(
    String url,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final headers = await _getHeaders();
      Uri uri = Uri.parse(url);
      if (queryParameters != null && queryParameters.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParameters);
      }

      if (kDebugMode) {
        print("🌐 [API Request] POST ${uri.toString()}");
        if (data != null) print("📦 [Request Body] ${jsonEncode(data)}");
        if (queryParameters != null) {
          print("🔍 [Query Params] $queryParameters");
        }
      }

      final response = await http
          .post(
            uri,
            headers: headers,
            body: data != null ? jsonEncode(data) : null,
          )
          .timeout(const Duration(seconds: 30));

      return returnResponse(response);
    } on SocketException {
      throw const NoInternetException();
    } on TimeoutException {
      throw const TimeoutException();
    } on http.ClientException catch (e) {
      throw ServerException(e.message);
    }
  }

  // Helper method to get headers with auth token
  Future<Map<String, String>> _getHeaders() async {
    final headers = {
      "Content-Type": "application/json",
    };

    // Add authorization header if token exists
    if (_sessionController.hasValidToken) {
      headers['Authorization'] = 'Bearer ${_sessionController.authToken}';
    }

    if (kDebugMode) {
      print("🔹 [HEADERS] $headers");
    }

    return headers;
  }

  dynamic returnResponse(http.Response response) {
    try {
      dynamic responseBody;
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {
        responseBody = response.body;
      }

      if (kDebugMode) {
        print('''🌐 [API Response]
Status: ${response.statusCode}
URL: ${response.request?.url}
Headers: ${response.headers}
Body: $responseBody''');
      }

      switch (response.statusCode) {
        case 200:
        case 201:
          return responseBody;
        case 400:
          throw BadRequestException(responseBody);
        case 401:
          // Clear session if unauthorized
          SessionController().clearSession();
          throw UnauthorizedException(responseBody);
        case 403:
          throw ForbiddenException(responseBody);
        case 404:
          throw NotFoundException(responseBody);
        case 429: // Rate limiting
          final retryAfter = response.headers['retry-after'];
          throw RateLimitException(
            retryAfter != null
                ? Duration(seconds: int.parse(retryAfter))
                : const Duration(seconds: 30),
            responseBody,
          );
        case 500:
          throw InternalServerErrorException(responseBody);
        case 502:
        case 503:
        case 504:
          throw ServerException('Server unavailable', responseBody);
        default:
          throw ServerException(
            'Unexpected status code: ${response.statusCode}',
            responseBody,
          );
      }
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error processing response: $e');
      }
      rethrow;
    }
  }
}
