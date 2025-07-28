import 'package:client_app/core/index.dart';
import 'package:client_app/core/theme/app_theme.dart';
import 'package:client_app/services/session_manager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'blocs/auth/login_bloc.dart';
import 'blocs/income_source/income_source_bloc.dart';
import 'blocs/persional_info/persional_info_bloc.dart';
import 'core/di/di_config.dart';
import 'core/widgets/global_loader.dart';
import 'data/network/network_service_api.dart';

GetIt getIt = GetIt.instance;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await SessionController().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => getIt<LoginBloc>(),
        ),
        BlocProvider<PersionalInfoBloc>(
          create: (context) => getIt<PersionalInfoBloc>(),
        ),
        ChangeNotifierProvider<GlobalLoaderProvider>(
          create: (_) => GlobalLoaderProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          // Set the global loader provider after the first frame
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final provider = Provider.of<GlobalLoaderProvider>(context, listen: false);
            NetworkServiceApi.setGlobalLoader(provider);
          });
          return GlobalLoader(
            notifier: Provider.of<GlobalLoaderProvider>(context, listen: false),
            child: MaterialApp.router(
              title: 'Tax App',
              theme: AppTheme.lightTheme,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              builder: (context, child) => Stack(
                children: [
                  child!,
                  const GlobalLoaderOverlay(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
