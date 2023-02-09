import 'package:fbus_app/src/assets/constant.dart';
import 'package:fbus_app/src/models/onboard_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isViewed = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Get.toNamed('/');
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: primary,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(screens[index].img),
                  Container(
                    height: 10.0,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 25 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color:
                                      currentIndex == index ? primary : kgrey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (index == screens.length - 1) {
                        await _storeOnboardInfo();
                        if (!mounted) return;
                        Get.toNamed('/');
                      }

                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(15.0)),
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Text(
                          "Next",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(
                          Icons.arrow_forward_sharp,
                          color: Colors.white,
                        )
                      ]),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
