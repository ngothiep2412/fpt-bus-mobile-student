import 'package:fbus_app/src/assets/constant.dart';
import 'package:fbus_app/src/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textLoginByDriver(),
      ),
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column(
            children: [
              _imageCover(),
              _textAppName(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.42,
      color: primary,
    );
  }

  Widget _textAppName() {
    return const Text(
      "F-BUS APP",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.48,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.35, left: 50, right: 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldEmail(),
            _textFieldPassword(),
            _buttonLogin()
          ],
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 45),
      child: const Text(
        'LOGIN BY STUDENT',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            hintText: 'Email', prefixIcon: Icon(Icons.email)),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: const InputDecoration(
            hintText: 'Password', prefixIcon: Icon(Icons.lock)),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.login(),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15)),
          child: const Text(
            'LOGIN',
            style: TextStyle(color: Colors.black),
          )),
    );
  }

  Widget _textLoginByDriver() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'OR NOT STUDENT?',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        const SizedBox(width: 7),
        GestureDetector(
          onTap: () => con.goToRegisterPage(),
          child: Text(
            'LOGIN BY DRIVER',
            style: TextStyle(
                color: primary, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ],
    );
  }

// IMAGE
  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 15),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/delivery.png',
          width: 130,
          height: 130,
        ),
      ),
    );
  }
}
