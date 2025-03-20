import 'dart:async';

import 'package:client_app/core/route/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        () => GoRouter.of(context).go(RouteName.phoneNo));
  }
}
