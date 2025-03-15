import 'package:client_app/core/index.dart';
import 'package:client_app/core/theme/app_theme.dart';
import 'package:client_app/data/repositories_impls/auth/auth_repository_impl.dart';
import 'package:client_app/domain/repositories/auth/auth_repository.dart';
import 'package:client_app/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void main() {
  servicesLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      initialRoute: RouteName.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: SplashScreen(),
    );
  }
}

void servicesLocator() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}
