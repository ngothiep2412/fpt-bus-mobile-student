import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SendOTPController extends GetxController {
  List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  List<FocusNode> focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  String expectedOtp = "1234";

  void checkOtp() {
    String enteredOtp = "";

    for (var i = 0; i < 4; i++) {
      enteredOtp += controllers[i].text;
    }

    if (enteredOtp == expectedOtp) {
      gotoMainPage();
      Get.snackbar('Success', 'Successful authentication');
    } else {
      Get.snackbar('Failed', 'Failed authentication');
    }
  }

  void gotoMainPage() {
    Get.toNamed('/home-driver');
  }

  void sentOtpAgain() {}
}
