import 'package:client_app/core/di/di_container.dart';
import 'package:client_app/data/repositories_impls/auth/auth_repository_impl.dart';
import 'package:client_app/domain/repositories/auth/auth_repository.dart';

import '../../data/repositories_impls/document_upload/document_upload_repositroy_impl.dart';
import '../../data/repositories_impls/income_source/income_source_repository_impl.dart';
import '../../data/repositories_impls/persional_info/persional_info_repositroy_impl.dart';
import '../../domain/repositories/document_upload/document_upload_repository.dart';
import '../../domain/repositories/income_source/income_source_repository.dart';
import '../../domain/repositories/persional_info/persional_info_repository.dart';

Future<void> registerRepositories() async {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<IncomeSourceRepository>(
        () => IncomeSourceRepositoryImpl(),
  );
  getIt.registerLazySingleton<PersionalInfoRepository>(
        () => PersionalInfoRepositoryImpl(),
  );

  getIt.registerLazySingleton<DocumentUploadRepository>(
        () => DocumentRepositoryImpl(),
  );

}