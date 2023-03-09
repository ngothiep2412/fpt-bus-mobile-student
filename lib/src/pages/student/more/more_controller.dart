import 'package:fbus_app/src/global/global.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MoreController extends GetxController {
  final storage = FlutterSecureStorage();
  void signOut() async {
    GetStorage().remove('user');
    await storage.deleteAll();
    fAuth.signOut();
    await googleSignIn.signOut();
    Get.offNamedUntil('/splash', (route) => false);
  }
}
