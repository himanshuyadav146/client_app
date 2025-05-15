import 'package:client_app/core/index.dart';
import 'package:client_app/core/theme/app_theme.dart';
import 'package:client_app/data/repositories_impls/auth/auth_repository_impl.dart';
import 'package:client_app/domain/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide BLoCs
        BlocProvider<LoginBloc>(
          create: (context) => getIt<LoginBloc>(),
        ),
        BlocProvider<IncomeSourceBloc>(
          create: (context) => getIt<IncomeSourceBloc>(),
        ),

        // Provide models
        // ChangeNotifierProvider<PersionalInfoModel>(
        //   create: (context) => getIt<PersionalInfoModel>(),
        // ),
      ],
      child: MaterialApp.router(
        title: 'Tax App',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

void servicesLocator() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerFactory<LoginBloc>(
          () => LoginBloc(authRepository: getIt<AuthRepository>()));

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