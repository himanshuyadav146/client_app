import 'package:client_app/data/network/network_service_api.dart';

import '../../../config/app_urls.dart';
import '../../../data/models/auth_models/auth_response.dart';

class AuthRepository {
  final _api = NetworkServiceApi();

  Future<AuthResponse> login(dynamic data) async {
    final res = await _api.postApi(baseUrl + loginUrl, data);
    return AuthResponse.fromJson(res);
  }
}
