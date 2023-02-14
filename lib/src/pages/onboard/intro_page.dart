import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './../../const/colors.dart';
import './../../models/onboard_model.dart';
import './../../utils/helper.dart';

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  var _controller;
  late int count;

  @override
  void initState() {
    _controller = PageController();
    count = 0;
    super.initState();
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Helper.getScreenWidth(context),
      height: Helper.getScreenHeight(context),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              bgImage(),
              circleAvatar(),
              const SizedBox(
                height: 20,
              ),
              textIntro(),
              const SizedBox(
                height: 20,
              ),
              descIntro(),
              const SizedBox(
                height: 25,
              ),
              btnNext()
            ],
          ),
        ),
      ),
    ));
  }

  Widget bgImage() {
    return Container(
      height: 400,
      width: double.infinity,
      child: PageView.builder(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            count = value;
          });
        },
        itemBuilder: (context, index) {
          return Image.asset(
            Helper.getAssetName(screens[index].img),
          );
        },
        itemCount: screens.length,
      ),
    );
  }

  Widget circleAvatar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: count == 0 ? AppColor.orange : AppColor.placeholder,
        ),
        const SizedBox(
          width: 5,
        ),
        CircleAvatar(
          radius: 5,
          backgroundColor: count == 1 ? AppColor.orange : AppColor.placeholder,
        ),
        const SizedBox(
          width: 5,
        ),
        CircleAvatar(
          radius: 5,
          backgroundColor: count == 2 ? AppColor.orange : AppColor.placeholder,
        )
      ],
    );
  }

  Widget textIntro() {
    return Text(
      screens[count].text,
      style: const TextStyle(
        color: AppColor.primary,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget descIntro() {
    return Text(
      screens[count].desc,
      style: const TextStyle(
        color: AppColor.primary,
        fontSize: 10,
      ),
    );
  }

  Widget btnNext() {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (count == screens.length - 1) {
            await _storeOnboardInfo();
            Get.toNamed('/splash');
          }
          _controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.bounceIn,
          );
        },
        child: const Text(
          "Next",
          style: TextStyle(color: AppColor.textColor),
        ),
      ),
    );
  }
}
