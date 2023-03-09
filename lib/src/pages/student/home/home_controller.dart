import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/models/trip_model.dart';
import 'package:fbus_app/src/models/users.dart';
import 'package:fbus_app/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

FlutterSecureStorage storage = FlutterSecureStorage();

class HomeController extends GetxController {
  var user = UserModel.fromJson(GetStorage().read('user') ?? {}).obs;
  UsersProviders usersProviders = UsersProviders();
  final routeTextEditting = TextEditingController();
  DateTime? selectedDate;

  void searchTheBus(BuildContext context) async {
    String? jwtToken = await storage.read(key: 'jwtToken');
    String date = '2001-02-01';
    if (isValidForm(routeTextEditting.text, date)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);

      progressDialog.show(
        max: 200,
        msg: 'Searching data...',
        progressValueColor: Colors.white,
        progressBgColor: AppColor.orange,
        // msgColor: Colors.black,
      );

      // Timer(Duration(seconds: 3), () {
      //   Navigator.of(context, rootNavigator: true).pop();
      // });
      try {
        if (jwtToken != null) {
          List<TripModel> listTrip = await usersProviders.getDataTrip(
              jwtToken, date, routeTextEditting.text);
          if (listTrip != null) {
            await Future.delayed(Duration(milliseconds: 500));
            progressDialog.close();
          }
          print('LIST TRIP DEPARTURE: ${listTrip[0].departure}');
          print('LIST TRIP DESTINATION: ${listTrip[0].destination}');
          print('LIST TRIP DRIVER NAME: ${listTrip[0].driverName}');
          print('LIST TRIP TICKET QUANTITY: ${listTrip[0].ticketQuantity}');
        }
      } catch (err) {
        // Show a SnackBar with the error message
        Get.snackbar('Error', 'Failed to search the bus');

        // Navigate to the Home page
        Get.offAllNamed('/navigation');
      }

      print('routeTextEditting: ${routeTextEditting.text}');

      // Get.toNamed('/navigation/home/list-bus');
      // Get.toNamed('/navigation/home/booking-bus');
    }
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

  bool isValidForm(String routeName, String? date) {
    if (routeName.isEmpty) {
      Get.snackbar('Invalid from', 'You must enter your route');
      return false;
    } else if (date == null) {
      Get.snackbar('Invalid from', 'You must enter your date');
      return false;
    }
    return true;
  }
}
