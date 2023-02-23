import 'package:fbus_app/src/global/global.dart';
import 'package:fbus_app/src/models/users.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  var user = UserModel.fromJson(GetStorage().read('user') ?? {}).obs;
  final storage = FlutterSecureStorage();

  void signOut() async {
    GetStorage().remove('user');
    await storage.deleteAll();
    fAuth.signOut();
    await googleSignIn.signOut();
    Get.offNamedUntil('/splash', (route) => false);
  }

  void goToProfileUpdate() {
    Get.toNamed('/navigation/profile/update');
  }
}
