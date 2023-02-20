import 'package:get/get.dart';
import 'package:flutter/material.dart';

import './landing_controller.dart';
import './../../const/colors.dart';
import './../../utils/helper.dart';

class LandingPage extends StatelessWidget {
  LandingController con = Get.put(LandingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Helper.getScreenWidth(context),
      height: Helper.getScreenHeight(context),
      child: Stack(
        children: [
          _loginBackground(context),
          _loginLogo(),
          _loginButton(context)
        ],
      ),
    ));
  }

  Widget _loginBackground(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: Helper.getScreenHeight(context) * 0.44,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(72, 174, 158, 158),
                offset: Offset(0, 15),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ClipPath(
            clipper: CustomClipperAppBar(),
            child: Container(
              width: double.infinity,
              height: Helper.getScreenHeight(context) * 0.44,
              decoration: ShapeDecoration(
                color: AppColor.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Image.asset(
                Helper.getAssetName("login_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginLogo() {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        Helper.getAssetName("fbus.png"),
        width: 280,
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: Helper.getScreenHeight(context) * 0.30,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(children: [
          _textSlogan(),
          const SizedBox(
            height: 50,
          ),
          _btnLoginByStudent(),
          const SizedBox(
            height: 20,
          ),
          _btnLoginByDriver(),
          const Spacer(
            flex: 2,
          ),
        ]),
      ),
    );
  }

  Widget _textSlogan() {
    return const Flexible(
      child: Text(
        "Travel with ease with online bus booking.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _btnLoginByStudent() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            AppColor.orange,
          ),
        ),
        onPressed: () => con.loginGoogle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Helper.getAssetName(
                "google.png",
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            const Text(
              "Login by student",
              style: TextStyle(
                color: AppColor.textColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _btnLoginByDriver() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(AppColor.orange),
          shape: MaterialStateProperty.all(
            const StadiumBorder(
              side: BorderSide(color: AppColor.orange, width: 1.5),
            ),
          ),
        ),
        onPressed: () => con.goToLoginByDriverPage(),
        child: const Text("Login by driver"),
      ),
    );
  }
}

class CustomClipperAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width * 0.24, size.height);
    Offset endPoint = Offset(size.width * 0.25, size.height * 0.96);
    Offset controlPoint2 = Offset(size.width * 0.3, size.height * 0.78);
    Offset endPoint2 = Offset(size.width * 0.5, size.height * 0.78);
    Offset controlPoint3 = Offset(size.width * 0.7, size.height * 0.78);
    Offset endPoint3 = Offset(size.width * 0.75, size.height * 0.96);
    Offset controlPoint4 = Offset(size.width * 0.76, size.height);
    Offset endPoint4 = Offset(size.width * 0.79, size.height);
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.21, size.height)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint2.dx,
        endPoint2.dy,
      )
      ..quadraticBezierTo(
        controlPoint3.dx,
        controlPoint3.dy,
        endPoint3.dx,
        endPoint3.dy,
      )
      ..quadraticBezierTo(
        controlPoint4.dx,
        controlPoint4.dy,
        endPoint4.dx,
        endPoint4.dy,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
