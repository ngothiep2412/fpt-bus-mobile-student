import 'package:fbus_app/src/models/users.dart';
import 'package:fbus_app/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

FlutterSecureStorage storage = FlutterSecureStorage();

class HomeController extends GetxController {
  var user = UserModel.fromJson(GetStorage().read('user') ?? {}).obs;
  UsersProviders usersProviders = UsersProviders();
  final routeTextEditting = TextEditingController();
  DateTime? selectedDate;

  void searchTheBus(BuildContext context) {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => ProgressDialog(
    //     message: "Finding the bus, Please wait ....",
    //   ),
    // );

    // Timer(Duration(seconds: 3), () {
    //   Navigator.of(context, rootNavigator: true).pop();
    // });

    print('routeTextEditting: ${routeTextEditting.text}');
    print('_selectedDate2322: $selectedDate');
    // Get.toNamed('/navigation/home/list-bus');
    Get.toNamed('/navigation/home/booking-bus');
  }

  // This function is designed for pushing notifications.
  void pushNotification() async {
    String? jwtToken = await storage.read(key: 'jwtToken');
    print('TEST jwtToken: $jwtToken');
    String? fireToken = await storage.read(key: 'firebaseToken');
    print('TEST fireToken: $fireToken');

    try {
      usersProviders.uploadNotification(
          fireToken!, "Test notification 222", "test", jwtToken!);
    } catch (err) {
      // Show a SnackBar with the error message
      Get.snackbar('Error', 'Failed to upload notification');

      // Navigate to the Home page
      Get.offAllNamed('/navigation');
    }
  }
}
