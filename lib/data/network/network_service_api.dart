import 'dart:convert';
import 'dart:io';

import 'package:client_app/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;

class NetworkServiceApi implements BaseApiServices {
  @override
  Future getApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(e.toString());
    }
  }

  @override
  Future postApi(String url, data) async {
    if (kDebugMode) {
      print('url - : $url');
      print('data - : $data');
      print("🔹 [REQUEST] Body: ${jsonEncode(data)}");
    }
    final Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    try {
      final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(data));
      return returnResponse(response);
    } on SocketException catch (e) {
      throw ServerException(e.toString());
    }
  }
}

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic jsonResponse = jsonDecode(response.body);
      return jsonResponse;

    case 400:
      throw ServerException();

    case 500:
      throw ServerException();

    default:
      throw ServerException();
  }
}
