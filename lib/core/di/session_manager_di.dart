
import '../../main.dart';
import '../../services/session_manager/session_manager.dart';

Future<void> registerSessionManager() async {
  getIt.registerSingleton<SessionController>(SessionController());
  await getIt<SessionController>().initialize();
}