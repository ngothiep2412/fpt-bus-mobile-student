import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/utils/helper.dart';
import 'package:fbus_app/src/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginController con = Get.put(LoginController());

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
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        clipper: CustomClipperAppBar(),
        child: Container(
          width: double.infinity,
          height: Helper.getScreenHeight(context) * 0.45,
          decoration: ShapeDecoration(
            color: AppColor.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginLogo() {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        Helper.getAssetName("fbus.png"),
        width: 260,
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
          const Spacer(
            flex: 2,
          ),
          CustomTextInput(
            hintText: "Your phone",
            textController: con.phoneController,
            textInputType: TextInputType.number,
            key: const ValueKey('my-custom-text-input'),
          ),
          const SizedBox(
            height: 20,
          ),
          _btnSendOtp(),
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
        "Travel with ease with online bus ticket booking.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: AppColor.placeholder,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _btnSendOtp() {
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
        onPressed: () => con.login(),
        child: const Text("Send OTP"),
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
