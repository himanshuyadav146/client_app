import 'package:client_app/core/route/route_name.dart';
import 'package:flutter/material.dart';
import '../../views/index.dart';

import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteName.splashScreen,
    routes: [
      GoRoute(
        path: RouteName.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.home,
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: RouteName.phoneNo,
        builder: (context, state) => const PhoneNoView(),
      ),
      GoRoute(
        path: RouteName.otpVerification,
        builder: (context, state) => const OtpVerificationView(),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(body: Center(child: Text('Page not found'))),
    ),
  );
}
