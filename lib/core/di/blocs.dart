import 'package:client_app/core/di/di_container.dart';
import 'package:client_app/blocs/auth/login_bloc.dart';
import 'package:client_app/blocs/income_source/income_source_bloc.dart';

import '../../domain/repositories/auth/auth_repository.dart';
import '../../domain/repositories/income_source/income_source_repository.dart';

Future<void> registerBlocs() async {
  getIt.registerFactory<LoginBloc>(
        () => LoginBloc(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerFactory<IncomeSourceBloc>(
        () => IncomeSourceBloc(getIt<IncomeSourceRepository>()),
  );
}