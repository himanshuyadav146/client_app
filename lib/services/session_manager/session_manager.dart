import 'dart:convert';
import 'package:client_app/data/models/auth_models/auth_response.dart';
import 'package:client_app/data/models/auth_models/otp_verification_response.dart';
import 'package:client_app/data/models/auth_models/email_auth_response.dart';
import '../storage/local_storage.dart';

class SessionController {
  static final SessionController _instance = SessionController._internal();
  final LocalStorage _localStorage = LocalStorage();
  // AuthResponse? authResponse;
  OTPVerificationResponse? authResponse;
  bool isLoggedIn = false;
  String? _authToken;

  SessionController._internal();

  factory SessionController() => _instance;

  String? get authToken => _authToken;

  // Initialize session from storage
  Future<void> initialize() async {
    try {
      final userData = await _localStorage.getValues('user');
      final isLogin = await _localStorage.getValues('isLoggedIn');
      final token = await _localStorage.getValues('auth_token');

      if (userData != null) {
        authResponse = OTPVerificationResponse.fromJson(jsonDecode(userData));
      }

      isLoggedIn = isLogin == 'true';
      _authToken = token;
    } catch (e) {
      print('Session initialization error: $e');
      await clearSession();
    }
  }

  Future<void> saveUserSession(OTPVerificationResponse response) async {
    try {
      authResponse = response;
      _authToken = response.token; // Assuming token is in AuthResponse
      isLoggedIn = true;

      await _localStorage.setValues('user', jsonEncode(response.toJson()));
      await _localStorage.setValues('isLoggedIn', 'true');
      await _localStorage.setValues('auth_token', response.token!);
    } catch (e) {
      print('Error saving session: $e');
      throw Exception('Failed to save user session');
    }
  }

  Future<void> saveEmailUserSession(EmailAuthResponse response) async {
    try {
      _authToken = response.token;
      isLoggedIn = true;

      await _localStorage.setValues('user', jsonEncode(response.toJson()));
      await _localStorage.setValues('isLoggedIn', 'true');
      await _localStorage.setValues('auth_token', response.token ?? '');
    } catch (e) {
      print('Error saving email session: $e');
      throw Exception('Failed to save email user session');
    }
  }

  Future<void> getUserFromPref() async {
    try {
      final user = await _localStorage.getValues('user');
      final isLogin = await _localStorage.getValues('isLoggedIn');
      if (user != null) {
        authResponse = OTPVerificationResponse.fromJson(jsonDecode(user));
        isLoggedIn = isLogin == 'true' ? true : false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveITRID(String itrId) async {
    try {
      await _localStorage.setValues('itr_id', itrId);
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getITRID() async {
    try {
      return await _localStorage.getValues('itr_id');
    } catch (e) {
      print(e);
      return null;
    }
  }

  String? getUserId() {
    if (hasValidToken && authResponse != null) {
      return authResponse!.data?.id;
    }
    return null;
  }

  // Clear session on logout
  Future<void> clearSession() async {
    try {
      await _localStorage.removeValues('user');
      await _localStorage.removeValues('isLoggedIn');
      await _localStorage.removeValues('auth_token');

      authResponse = null;
      _authToken = null;
      isLoggedIn = false;
    } catch (e) {
      print('Error clearing session: $e');
    }
  }

  // Check if token exists and is valid
  bool get hasValidToken => _authToken != null && isLoggedIn;
}