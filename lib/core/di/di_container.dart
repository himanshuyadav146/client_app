import 'package:client_app/core/di/repositories.dart';
import 'package:client_app/core/di/session_manager_di.dart';
import 'package:get_it/get_it.dart';

import 'blocs.dart';
import 'models.dart';

final GetIt getIt = GetIt.instance;

class DIContainer {
  static Future<void> init() async {
    await _registerRepositories();
    await _registerBlocs();
    await _registerModels();
    await _registerSessionManager();
  }

  static Future<void> _registerRepositories() async {
    await registerRepositories();
  }

  static Future<void> _registerBlocs() async {
    await registerBlocs();
  }

  static Future<void> _registerModels() async {
    await registerModels();
  }

  static Future<void> _registerSessionManager() async {
    await registerSessionManager();
  }
}