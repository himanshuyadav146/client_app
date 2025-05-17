import 'package:client_app/core/index.dart';
import 'package:client_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'blocs/auth/login_bloc.dart';
import 'blocs/income_source/income_source_bloc.dart';
import 'blocs/persional_info/persional_info_bloc.dart';
import 'core/di/di_config.dart';

GetIt getIt = GetIt.instance;

void main() async{
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide BLoCs using getIt for consistency
        BlocProvider<LoginBloc>(
          create: (context) => getIt<LoginBloc>(),
        ),
        BlocProvider<IncomeSourceBloc>(
          create: (context) => getIt<IncomeSourceBloc>(),
        ),
        BlocProvider<PersionalInfoBloc>(
          create: (context) => getIt<PersionalInfoBloc>(),
        ),
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
