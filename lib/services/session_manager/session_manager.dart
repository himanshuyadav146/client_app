import 'dart:convert';

import 'package:client_app/data/models/auth_models/auth_response.dart';

import '../storage/local_storage.dart';

class SessionController {

  static final SessionController _sessionController = SessionController._internal();
  final LocalStorage _localStorage = LocalStorage();
  AuthResponse authResponse = AuthResponse();
  bool isLoggedIn = false;

  SessionController._internal(){
    isLoggedIn = false;
  }

  factory SessionController() {
    return _sessionController;
  }


  Future<void> saveUserInPref(dynamic data) async {
    await _localStorage.setValues('user', data);
    _localStorage.setValues('isLoggedIn', 'true');
  }

  Future<void> getUserFromPref() async {
    try {
      final user = await _localStorage.getValues('user');
      final isLogin = await _localStorage.getValues('isLoggedIn');
      if (user != null) {
        authResponse = AuthResponse.fromJson(jsonDecode(user));
        isLoggedIn = isLogin == 'true' ? true : false;
      }
    } catch (e) {
      print(e);
    }
  }
}