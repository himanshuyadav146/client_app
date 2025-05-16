import 'package:client_app/core/di/di_container.dart';
import 'package:client_app/data/repositories_impls/auth/auth_repository_impl.dart';
import 'package:client_app/domain/repositories/auth/auth_repository.dart';

import '../../data/repositories_impls/income_source/income_source_repository_impl.dart';
import '../../domain/repositories/income_source/income_source_repository.dart';

Future<void> registerRepositories() async {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  getIt.registerLazySingleton<IncomeSourceRepository>(
        () => IncomeSourceRepositoryImpl(),
  );
}