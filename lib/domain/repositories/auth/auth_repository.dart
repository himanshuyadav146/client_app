import 'package:client_app/data/models/auth_models/otp_verification_response.dart';
import 'package:client_app/data/network/network_service_api.dart';

import '../../../config/app_urls.dart';
import '../../../data/models/auth_models/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(dynamic data);
  Future<OTPVerificationResponse> otpVerify(dynamic data);
}
