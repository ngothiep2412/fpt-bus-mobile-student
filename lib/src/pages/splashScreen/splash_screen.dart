import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../utils/helper.dart';
import './../../global/global.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  startTimer() {
    _timer = Timer(const Duration(seconds: 3), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Get.offNamedUntil('/home', (route) => false);
      } else {
        //send user to home screen
        Get.offNamedUntil('/', (route) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: Stack(
          children: [
            _splashImage(),
            _logo(),
          ],
        ),
      ),
    );
  }

  Widget _splashImage() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        Helper.getAssetName("splashIcon.png"),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _logo() {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        Helper.getAssetName("fbus.png"),
        width: 280,
      ),
    );
  }
}
