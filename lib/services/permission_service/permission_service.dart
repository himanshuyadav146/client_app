import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> requestStoragePermission() async {
    if (await Permission.storage.isGranted) return;

    final result = await Permission.storage.request();

    if (!result.isGranted) {
      throw Exception('Storage permission is required.');
    }
  }
}
