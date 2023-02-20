import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './../../widgets/custom_navbar.dart';
import './../../pages/home/home_controller.dart';

class HomePage extends StatelessWidget {
  HomeController con = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    // *TODO: Design a search form with input fields for "from", "to" and "date" and a search button

    return Scaffold(
      body: Stack(children: const [
        Positioned(
          bottom: 0,
          left: 0,
          child: CustomNavBar(
            home: true,
          ),
        ),
      ]),
    );
  }
}
