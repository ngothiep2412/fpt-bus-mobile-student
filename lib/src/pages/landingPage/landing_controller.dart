import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../global/global.dart';
import '../../models/response_api.dart';
import './../../providers/users_provider.dart';

class LandingController extends GetxController {
  UsersProviders usersProviders = UsersProviders();
  final storage = const FlutterSecureStorage();
  void goToLoginByDriverPage() {
    Get.toNamed('/login-by-driver');
  }

  Future<void> loginGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final User? firebaseUser =
            (await fAuth.signInWithCredential(credential).catchError((msg) {
          Get.snackbar("Error", msg);
        }))
                .user;

        if (firebaseUser != null) {
          // Split the email address at the "@" symbol to get the domain
          final emailParts = firebaseUser.email!.split('@');
          final emailDomain = emailParts[1];

          // Check if the domain is authorzed
          final authorizedDomains = ['fpt.edu.vn'];
          if (authorizedDomains.contains(emailDomain)) {
            String token = await firebaseUser.getIdToken();
            print('Get token from firebase: $token');
            try {
              ResponseApi responseApi = await usersProviders.loginGoogle(token);
              // Store the JWT token in the local storage for later use
              currentFirebaseUser = firebaseUser;
              final data = responseApi.data;
              final userJson = data['user'];

              // ! Bug 01: There is a missing 'if else' statement to verify the user's role

              final jwtToken = data['accessToken'];
              GetStorage().write('user', userJson);
              await storage.write(key: 'jwtToken', value: jwtToken);
              goToHomePage();
            } catch (err) {
              await googleSignIn.signOut();
              Get.snackbar("Login Fail", "An error occureed during login.");
            }
          } else {
            // The user is not authorized, so sign them out and show an error message
            await googleSignIn.signOut();
            Get.snackbar(
                "Error", "Your email domain is not authorized to log in.");
          }
        }
      }
    } catch (err) {
      print(err);
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }
}
