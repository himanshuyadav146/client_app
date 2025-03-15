import '../../../config/app_urls.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../models/auth_models/auth_response.dart';
import '../../network/network_service_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _api = NetworkServiceApi();
  @override
  Future<AuthResponse> login(data) async {
    final res = await _api.postApi(baseUrl + loginUrl, data);
    return AuthResponse.fromJson(res);
  }
//   final _api = NetworkServiceApi();
//   AuthRepository({
//     required NetworkServiceApi _api,
// });

  // Future<AuthResponse> login(dynamic data) async {
  //   final res = await _api.postApi(baseUrl + loginUrl, data);
  //   return AuthResponse.fromJson(res);
  // }
}
