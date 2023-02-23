import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/pages/student/appBar/student_navigation_bar_controller.dart';
import 'package:fbus_app/src/pages/student/home/home_page.dart';
import 'package:fbus_app/src/pages/student/profile/info/profile_page.dart';
import 'package:fbus_app/src/utils/custom_animated_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class StudentNavigationBar extends StatelessWidget {
  StudentNavigationBarController con =
      Get.put(StudentNavigationBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomBar(),
      body: Obx(() => IndexedStack(
            index: con.indexTab.value,
            children: [
              HomePage(),
              HomePage(),
              HomePage(),
              ProfilePage(),
            ],
          )),
    );
  }

  Widget _bottomBar() {
    return Obx(() => CustomAnimatedBottomBar(
          containerHeight: 56,
          backgroundColor: AppColor.placeholderBg,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          selectedIndex: con.indexTab.value,
          onItemSelected: (index) => con.changeTab(index),
          items: [
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: Icon(Ionicons.home_outline),
                title: Text("Home"),
                activeColor: AppColor.orange,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: Icon(Ionicons.ticket_outline),
                title: Text("My Tickets"),
                activeColor: AppColor.orange,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: Icon(Ionicons.notifications_outline),
                title: Text("Notifications"),
                activeColor: AppColor.orange,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: Icon(Ionicons.person_outline),
                title: Text("Profile"),
                activeColor: AppColor.orange,
                inactiveColor: Colors.black),
          ],
        ));
  }
}
