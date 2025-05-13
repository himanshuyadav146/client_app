import 'package:client_app/core/index.dart';
import 'package:client_app/core/theme/app_theme.dart';
import 'package:client_app/data/repositories_impls/auth/auth_repository_impl.dart';
import 'package:client_app/domain/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'blocs/auth/login_bloc.dart';
import 'blocs/income_source/income_source_bloc.dart';
import 'data/models/persional_info/persional_info_model.dart';

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
    return MaterialApp.router(
      title: 'Tax App',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}

void servicesLocator() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerFactory<LoginBloc>(
      () => LoginBloc(authRepository: getIt<AuthRepository>()));

  // Register IncomeSourceBloc as a LazySingleton (better for stateful UI updates)
  getIt.registerLazySingleton<IncomeSourceBloc>(() => IncomeSourceBloc());
  getIt.registerLazySingleton<PersionalInfoModel>(() => PersionalInfoModel(
        firstName: '',
        middleName: '',
        lastName: '',
        panNumber: '',
        email: '',
        dob: '',
      ));
}
