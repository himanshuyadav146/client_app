import 'package:client_app/core/route/route_name.dart';
import 'package:flutter/material.dart';
import '../../views/index.dart';
import '../error/exceptions.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case RouteName.phoneNo:
        return MaterialPageRoute(builder: (_) => const PhoneNoView());
      case RouteName.otpVerification:
        return MaterialPageRoute(builder: (_) => const OtpVerificationView());
      // case productDetails:
      //   Product product = routeSettings.arguments as Product;
      //   return MaterialPageRoute(
      //       builder: (_) => ProductDetailsView(product: product));
      // case userProfile:
      //   User user = routeSettings.arguments as User;
      //   return MaterialPageRoute(
      //       builder: (_) => UserProfileScreen(
      //             user: user,
      //           ));
      // case orderCheckout:
      //   List<CartItem> items = routeSettings.arguments as List<CartItem>;
      //   return MaterialPageRoute(
      //       builder: (_) => OrderCheckoutView(
      //             items: items,
      //           ));
      // case deliveryDetails:
      //   return MaterialPageRoute(builder: (_) => const DeliveryInfoView());
      // case orders:
      //   return MaterialPageRoute(builder: (_) => const OrderView());
      // case settings:
      //   return MaterialPageRoute(builder: (_) => const SettingsView());
      // case notifications:
      //   return MaterialPageRoute(builder: (_) => const NotificationView());
      // case about:
      //   return MaterialPageRoute(builder: (_) => const AboutView());
      // case filter:
      //   return MaterialPageRoute(builder: (_) => const FilterView());
      default:
        throw RouteException('Route not found!');
    }
  }
}
