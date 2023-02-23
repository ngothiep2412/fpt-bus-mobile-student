import 'package:fbus_app/src/providers/users_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();

  UsersProviders usersProviders = UsersProviders();

  final RegExp phoneExp = RegExp(r'^[0-9]+$');

  void goToLoginByDriverPage() {
    Get.toNamed('/');
  }

  void login() async {
    String phone = phoneController.text.trim();

    if (isValidForm(phone)) {
      Get.toNamed('/sent-otp');
    }
    // String email = emailController.text.trim();
    // String password = passwordController.text.trim();
    // if (isValidForm(email, password)) {
    //   ResponseApi responseApi = await usersProviders.login(email, password);

    //   print(
    //       'Response Api: ${responseApi.toJson()} + password: ${responseApi.data['password']}');
    //   bool checkPassword =
    //       DBCrypt().checkpw(password, responseApi.data['password']);
    //   if (responseApi.success == true && checkPassword == true) {
    //     final User? firebaseUser = (await fAuth
    //             .createUserWithEmailAndPassword(
    //       email: email,
    //       password: password,
    //     )
    //             .catchError((msg) {
    //       Get.snackbar('Login failed', responseApi.message ?? '');
    //     }))
    //         .user;
    //     if (firebaseUser != null) {
    //       // GetStorage().write('user', responseApi.data);
    //       DatabaseReference databaseReference =
    //           FirebaseDatabase.instance.ref().child("data_login");
    //       databaseReference.set(responseApi.data);
    //       currentFirebaseUser = firebaseUser;
    //       goToHomePage();
    //       Get.snackbar('Login success', responseApi.message ?? '');
    //     } else {
    //       Get.snackbar('Login failed', responseApi.message ?? '');
    //     }
    //   }
    // }
  }

  void goToHomePage() {
    Get.toNamed('/navigation');
  }

  bool isValidForm(phone) {
    if (phone.isEmpty) {
      Get.snackbar('Invalid from', 'You must enter your phone');
      return true;
    }
    if (phoneExp.hasMatch(phone) == false) {
      Get.snackbar('Invalid from', 'You must enter number');
      return false;
    }
    return true;
  }
}
