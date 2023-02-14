import 'package:get/get.dart';
import 'package:fbus_app/src/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './../../providers/users_provider.dart';

class LandingController extends GetxController {
  UsersProviders usersProviders = UsersProviders();

  void goToLoginByDriverPage() {
    Get.toNamed('/login-by-driver');
  }

  Future<void> login() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final User? user =
            (await fAuth.signInWithCredential(credential).catchError((msg) {
          Get.snackbar("Error", msg);
        }))
                .user;
        String token = await user!.getIdToken();
        print('Token: $token');
        if (user != null) {
          final jwtToken = await usersProviders.postUser(user);
          // Store the JWT token in the local storage for later use
          print('jwtToken: $jwtToken');
          goToHomePage();
        }
      }
    } catch (err) {
      print(err);
    }
  }

  void goToHomePage() {
    Get.toNamed('/home');
  }
}
