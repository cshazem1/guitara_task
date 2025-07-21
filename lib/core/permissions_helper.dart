import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  static Future<bool> requestCameraAndMicPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }
}
