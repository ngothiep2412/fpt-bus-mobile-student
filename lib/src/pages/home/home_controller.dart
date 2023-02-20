import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../providers/users_provider.dart';

FlutterSecureStorage storage = FlutterSecureStorage();

class HomeController extends GetxController {
  UsersProviders usersProviders = UsersProviders();

  // This function is designed for pushing notifications.
  void pushNotification() async {
    String? jwtToken = await storage.read(key: 'jwtToken');
    print('TEST jwtToken: $jwtToken');
    String? fireToken = await storage.read(key: 'firebaseToken');
    print('TEST fireToken: $fireToken');

    try {
      usersProviders.uploadNotification(
          fireToken!, "Test notification", "test", jwtToken!);
    } catch (err) {
      // Show a SnackBar with the error message
      Get.snackbar('Error', 'Failed to upload notification');

      // Navigate to the Home page
      Get.offAllNamed('/home');
    }
  }
}
