import '../../../config/app_urls.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../models/auth_models/auth_response.dart';
import '../../models/auth_models/otp_verification_response.dart';
import '../../network/network_service_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _api = NetworkServiceApi();
  @override
  Future<AuthResponse> login(data) async {
    final res = await _api.postApi(baseUrl + sendOTPUrl, data);
    return AuthResponse.fromJson(res);
  }

  @override
  Future<OTPVerificationResponse> otpVerify(data) async {
    final res = await _api.postApi(baseUrl + verifyOTP, data);
    return OTPVerificationResponse.fromJson(res);
  }
}
