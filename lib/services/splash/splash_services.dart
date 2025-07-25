import 'dart:async';

import 'package:client_app/core/route/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../session_manager/session_manager.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    SessionController().getUserFromPref().then((value) {
      if (SessionController().isLoggedIn) {
        Timer(const Duration(seconds: 3),
            () => GoRouter.of(context).go(RouteName.tabbarScreen));
      } else {
        Timer(const Duration(seconds: 3),
            () => GoRouter.of(context).go(RouteName.emailLogin));
      }
    }).onError((error, stackTrace) {
      Timer(const Duration(seconds: 3),
          () => GoRouter.of(context).go(RouteName.emailLogin));
    });
  }
}
