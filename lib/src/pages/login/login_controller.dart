import 'package:fbus_app/src/global/global.dart';
import 'package:fbus_app/src/models/response_api.dart';
import 'package:fbus_app/src/providers/users_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProviders usersProviders = UsersProviders();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProviders.login(email, password);

      print(
          'Response Api: ${responseApi.toJson()} + password: ${responseApi.data['password']}');
      bool checkPassword =
          DBCrypt().checkpw(password, responseApi.data['password']);
      if (responseApi.success == true && checkPassword == true) {
        final User? firebaseUser = (await fAuth
                .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
                .catchError((msg) {
          Get.snackbar('Login failed', responseApi.message ?? '');
        }))
            .user;
        if (firebaseUser != null) {
          // GetStorage().write('user', responseApi.data);
          DatabaseReference databaseReference =
              FirebaseDatabase.instance.ref().child("data_login");
          databaseReference.set(responseApi.data);
          currentFirebaseUser = firebaseUser;
          goToHomePage();
          Get.snackbar('Login success', responseApi.message ?? '');
        } else {
          Get.snackbar('Login failed', responseApi.message ?? '');
        }
      }
    }
  }

  void goToHomePage() {
    Get.toNamed('/home');
  }

  bool isValidForm(String email, String password) {
    if (email.isEmpty) {
      Get.snackbar('Invalid from', 'You must enter the email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Invalid from', 'The email is not valid');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Invalid from', 'You must enter the password');
      return false;
    }

    return true;
  }
}
