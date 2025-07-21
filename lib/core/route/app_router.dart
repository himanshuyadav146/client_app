import 'package:client_app/core/route/route_name.dart';
import 'package:client_app/views/documents_upload/documents_upload.dart';
import 'package:client_app/views/order_status/order_status.dart';
import 'package:client_app/views/payment/payment.dart';
import 'package:client_app/views/persional_info/persional_info.dart';
import 'package:client_app/views/tab_bar/tabbar_screen.dart';
import 'package:flutter/material.dart';
import '../../views/important_details/inportant_details.dart';
import '../../views/income_source/income_source.dart';
import '../../views/index.dart';
import '../../views/authentication/email_login_view.dart';
import '../../views/authentication/email_signup_view.dart';
import '../../views/authentication/forgot_password_view.dart';

import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteName.emailLogin,
    routes: [
      GoRoute(
        path: RouteName.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.tabbarScreen,
        builder: (context, state) => const TabbarScreen(),
      ),
      GoRoute(
        path: RouteName.home,
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: RouteName.phoneNo,
        builder: (context, state) => const PhoneNumberView(),
      ),
      GoRoute(
        path: RouteName.otpVerification,
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return OtpVerificationView(phoneNumber: phoneNumber);
        },
      ),
      // New Email Authentication Routes
      GoRoute(
        path: RouteName.emailLogin,
        builder: (context, state) => const EmailLoginView(),
      ),
      GoRoute(
        path: RouteName.emailSignup,
        builder: (context, state) => const EmailSignupView(),
      ),
      GoRoute(
        path: RouteName.forgotPassword,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: RouteName.incomeSource,
        builder: (context, state) => IncomeSourceView(),
      ),
      GoRoute(
        path: RouteName.persionalInfo,
        builder: (context, state) => PersionalInfo(),
      ),
      GoRoute(
        path: RouteName.importantDetails,
        builder: (context, state) => ImportantDetails(),
      ),
      GoRoute(
        path: RouteName.documentsUpload,
        builder: (context, state) => DocumentsUpload(),
      ),
      GoRoute(
        path: RouteName.payment,
        builder: (context, state) => PaymentPage(), // Corrected to PaymentPage
      ),
      GoRoute(
        path: RouteName.orderStatus,
        builder: (context, state) => OrderStatusScreen(),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(body: Center(child: Text('Page not found'))),
    ),
  );
}
