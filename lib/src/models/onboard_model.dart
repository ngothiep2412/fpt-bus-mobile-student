import 'package:flutter/material.dart';

class OnboardModel {
  String img;
  String text;
  String desc;
  Color bg;
  Color button;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
    required this.bg,
    required this.button,
  });
}

List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    img: 'assets/images/onboard-1.png',
    text: "Book your onlinebus ticket",
    desc: "Developed by group students",
    bg: Colors.white,
    button: const Color(0xFF4756DF),
  ),
  OnboardModel(
    img: 'assets/images/onboard-2.png',
    text: "Digital Bus Management System",
    desc: "Developed by group students",
    bg: const Color(0xFF4756DF),
    button: Colors.white,
  ),
  OnboardModel(
    img: 'assets/images/onboard-3.png',
    text: "Through notifications keep yourself updated",
    desc: "Developed by group students",
    bg: Colors.white,
    button: const Color(0xFF4756DF),
  ),
];
