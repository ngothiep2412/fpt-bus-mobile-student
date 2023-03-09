import 'package:fbus_app/src/models/users.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  var user = UserModel.fromJson(GetStorage().read('user') ?? {}).obs;
  final storage = FlutterSecureStorage();

  void goToProfileUpdate() {
    Get.toNamed('/profile/update');
  }
}
