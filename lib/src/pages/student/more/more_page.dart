import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/pages/student/more/more_controller.dart';
import 'package:fbus_app/src/theme/theme_controller.dart';
import 'package:fbus_app/src/utils/helper.dart';
import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class MorePage extends StatelessWidget {
  MoreController con = Get.put(MoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        implementLeading: false,
        titleString: "More",
      ),
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            // widget change mode is here
            Container(
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Change Mode',
                    style: TextStyle(fontSize: 15.0, color: AppColor.primary),
                  ),
                  SizedBox(width: 8.0),
                  LiteRollingSwitch(
                    value: Get.isDarkMode,
                    textOn: "Dark Mode",
                    textOff: "Light Mode",
                    colorOn: Color(0xff444654),
                    colorOff: Color.fromARGB(255, 238, 123, 65),
                    iconOn: Ionicons.moon,
                    iconOff: Ionicons.sunny,
                    textSize: 12.0,
                    textOnColor: Colors.white,
                    onChanged: (bool state) {
                      Get.find<ThemeController>().toggleTheme();
                    },
                    onDoubleTap: () {},
                    onSwipe: () {},
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MoreCard(
              image: Image.asset(
                Helper.getAssetIconName('ico_user.png'),
              ),
              name: "Profile Details",
              handler: () {
                Get.toNamed('/profile');
              },
            ),
            SizedBox(
              height: 10,
            ),
            MoreCard(
              image: Image.asset(
                Helper.getAssetIconName('ico_income.png'),
              ),
              name: "Payment Details",
              handler: () {
                () {};
              },
            ),
            SizedBox(
              height: 10,
            ),
            MoreCard(
              image: Image.asset(
                Helper.getAssetIconName('ico_aboutus.png'),
              ),
              name: "About Us",
              handler: () {
                () {};
              },
            ),
            SizedBox(
              height: 10,
            ),
            MoreCard(
              image: Image.asset(
                Helper.getAssetIconName('ico_logout.png'),
              ),
              name: "Logout",
              handler: () {
                con.signOut();
              },
            ),
          ]),
        ),
      )),
    );
  }
}

class MoreCard extends StatelessWidget {
  final String _name;
  final Image _image;
  final VoidCallback _handler;

  const MoreCard({
    Key? key,
    String name = '',
    required Image image,
    required VoidCallback handler,
  })  : _name = name,
        _image = image,
        _handler = handler,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handler,
      child: Container(
        height: 70,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: AppColor.orange.withOpacity(0.2),
                      ),
                      child: _image),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _name,
                    style: TextStyle(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 30,
                width: 30,
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: AppColor.placeholderBg,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.orange,
                  size: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
