import 'dart:async';

import 'package:client_app/core/route/route_name.dart';
import 'package:flutter/cupertino.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 3), () =>
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.phoneNo, (route) => false));
  }
}