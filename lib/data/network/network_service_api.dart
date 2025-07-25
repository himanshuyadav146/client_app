import 'dart:async';
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

  // @override
  // Future<dynamic> uploadFile(
  //     String url, {
  //       required String filePath,
  //       required String fieldName,
  //       Map<String, String>? additionalFields,
  //       Map<String, String>? headers,
  //       void Function(int bytesSent, int totalBytes)? onProgress,
  //     }) async {
  //   try {
  //     // Create multipart request
  //     final request = http.MultipartRequest('POST', Uri.parse(url));
  //
  //     // Add headers
  //     final defaultHeaders = await _getHeaders();
  //     // Add any specific headers passed to uploadFile first
  //     request.headers.addAll(headers ?? {});
  //     // Then add default headers (which might include 'Content-Type')
  //     request.headers.addAll(defaultHeaders);
  //
  //     // Crucially, remove 'Content-Type' if it was part of defaultHeaders or passed headers,
  //     // as MultipartRequest will set its own with the correct boundary.
  //     if (request.headers.containsKey('Content-Type')) {
  //       request.headers.remove('Content-Type');
  //       if (kDebugMode) {
  //         print("🔹 [Multipart Upload] Removed 'Content-Type' header to allow http.MultipartRequest to set it.");
  //       }
  //     }
  //
  //     // Add file
  //     final file = await http.MultipartFile.fromPath(fieldName, filePath);
  //     request.files.add(file);
  //
  //     // Add additional fields if provided
  //     if (additionalFields != null && additionalFields.isNotEmpty) {
  //       request.fields.addAll(additionalFields);
  //     }
  //
  //     if (kDebugMode) {
  //       print("🌐 [API Upload Request] POST $url");
  //       print("📁 [Uploading File] $filePath");
  //       if (additionalFields != null) {
  //         print("📦 [Additional Fields] $additionalFields");
  //       }
  //     }
  //
  //     // Send the request
  //     final streamedResponse = await request.send();
  //
  //     // Track progress if callback provided
  //     if (onProgress != null) {
  //       final contentLength = streamedResponse.contentLength ?? 0;
  //       var bytesReceived = 0;
  //       final responseStream = streamedResponse.stream.transform<List<int>>(
  //         StreamTransformer.fromHandlers(
  //           handleData: (data, sink) {
  //             bytesReceived += data.length;
  //             onProgress(bytesReceived, contentLength);
  //             sink.add(data);
  //           },
  //         ),
  //       );
  //
  //       // Convert to http.Response
  //       final response = await http.Response.fromStream(
  //         http.StreamedResponse(
  //           responseStream,
  //           streamedResponse.statusCode,
  //           contentLength: contentLength,
  //           headers: streamedResponse.headers,
  //           request: streamedResponse.request,
  //           isRedirect: streamedResponse.isRedirect,
  //           persistentConnection: streamedResponse.persistentConnection,
  //           reasonPhrase: streamedResponse.reasonPhrase,
  //         ),
  //       );
  //
  //       return returnResponse(response);
  //     } else {
  //       // No progress tracking needed
  //       final response = await http.Response.fromStream(streamedResponse);
  //       return returnResponse(response);
  //     }
  //   } on SocketException {
  //     throw const NoInternetException();
  //   } on TimeoutException {
  //     throw const TimeoutException();
  //   } on http.ClientException catch (e) {
  //     throw ServerException(e.message);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('⚠️ Error uploading file: $e');
  //     }
  //     throw ServerException('File upload failed: ${e.toString()}');
  //   }
  // }


  @override
  Future<dynamic> uploadFile(
      String url, {
        required String filePath,
        required String fieldName,
        Map<String, String>? additionalFields,
        Map<String, String>? headers,
        void Function(int bytesSent, int totalBytes)? onProgress,
      }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      final defaultHeaders = await _getHeaders();
      request.headers.addAll(headers ?? {});
      request.headers.addAll(defaultHeaders);

      // Remove 'content-type' to let MultipartRequest handle it
      request.headers.removeWhere((key, _) => key.toLowerCase() == 'content-type');

      // Add file
      final file = await http.MultipartFile.fromPath(fieldName, filePath);
      request.files.add(file);

      // Add additional fields if any
      if (additionalFields != null) {
        request.fields.addAll(additionalFields);
      }

      // Send request
      final streamedResponse = await request.send();

      final contentLength = streamedResponse.contentLength ?? 0;
      int bytesReceived = 0;

      // Collect bytes
      final chunks = <int>[];
      final completer = Completer<void>();

      streamedResponse.stream.listen(
            (chunk) {
          chunks.addAll(chunk);
          bytesReceived += chunk.length;
          if (onProgress != null) {
            onProgress(bytesReceived, contentLength);
          }
        },
        onDone: completer.complete,
        onError: completer.completeError,
        cancelOnError: true,
      );

      // Wait for full stream
      await completer.future;

      // Properly decode UTF8, even if GZIP or chunked
      final responseBody = utf8.decode(chunks);

      if (kDebugMode) {
        print('✅ Response body: $responseBody');
      }

      // Parse as JSON
      final parsedJson = jsonDecode(responseBody);
      return parsedJson;
    } on SocketException {
      throw const NoInternetException();
    } on TimeoutException {
      throw const TimeoutException();
    } on http.ClientException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error uploading file: $e');
      }
      throw ServerException('File upload failed: ${e.toString()}');
    }
  }



// Helper method to track upload progress
  Stream<http.StreamedResponse> _trackProgress(
      http.StreamedResponse response,
      void Function(int bytesSent, int totalBytes) onProgress,
      ) async* {
    final contentLength = response.contentLength ?? 0;
    var bytesReceived = 0;

    final stream = response.stream.asBroadcastStream();

    await for (var chunk in stream) {
      bytesReceived += chunk.length;
      onProgress(bytesReceived, contentLength);
      yield http.StreamedResponse(
        Stream.value(chunk),
        response.statusCode,
        contentLength: contentLength,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    }
  }


  // Helper method to get headers with auth token
  Future<Map<String, String>> _getHeaders() async {
    final headers = {
      "Content-Type": "application/json",
    };

    // TODO - Need to remove
    headers['Authorization'] = 'Bearer eyJhbGdvIjoiSFMyNTYiLCJ0eXBlIjoiSldUIiwiZXhwaXJlIjoxNzc5NjY0OTgyfQ==.eyJpc3MiOiJhbGxpbmRpYWl0ci5pbiIsIm1vYmlsZSI6IjkwOTY0NjQ1MzQiLCJ0aW1lIjoxNzQ4MTA4MDMwfQ==.MjhjZWU0NGQyYzU2YTI2MGEwYTYyYjFhZmRlYWI0OWRhM2U2YjI1OThmZjhkYTIwZjZmNTgzNTQyOGM4ZmUzMA==';

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
