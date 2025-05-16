import 'package:client_app/core/di/repositories.dart';
import 'package:client_app/core/di/blocs.dart';
import 'package:client_app/core/di/models.dart';

import 'di_container.dart';

Future<void> configureDependencies() async {
  await DIContainer.init();
}