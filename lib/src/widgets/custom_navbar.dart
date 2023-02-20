import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/colors.dart';
import '../utils/helper.dart';

class CustomNavBar extends StatelessWidget {
  final bool home;
  final bool menu;
  final bool offer;
  final bool profile;
  final bool more;

  const CustomNavBar(
      {Key? key,
      this.home = false,
      this.menu = false,
      this.offer = false,
      this.profile = false,
      this.more = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: Helper.getScreenWidth(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CustomNavBarClipper(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                // curve: Curves.easeInOut,
                child: Container(
                  height: 60,
                  width: Helper.getScreenWidth(context),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      menuNavbar(),
                      offerNavbar(),
                      const SizedBox(
                        width: 20,
                      ),
                      profileNavbar(),
                      moreNavbar()
                    ],
                  ),
                ),
              ),
            ),
          ),
          homeNavbar()
        ],
      ),
    );
  }

  Widget menuNavbar() {
    return GestureDetector(
      onTap: () {
        if (!menu) {
          //   Navigator.of(context)
          //       .pushReplacementNamed(MenuScreen.routeName);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          menu
              ? Image.asset(
                  Helper.getAssetName("more_filled.png"),
                )
              : Image.asset(
                  Helper.getAssetName("more.png"),
                ),
          const SizedBox(
            height: 10,
          ),
          menu
              ? const Text("Menu", style: TextStyle(color: AppColor.orange))
              : const Text("Menu"),
        ],
      ),
    );
  }

  Widget offerNavbar() {
    return GestureDetector(
      onTap: () {
        if (!offer) {
          // Navigator.of(context)
          //     .pushReplacementNamed(OfferScreen.routeName);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          offer
              ? Image.asset(
                  Helper.getAssetName("bag_filled.png"),
                )
              : Image.asset(
                  Helper.getAssetName("bag.png"),
                ),
          const SizedBox(
            height: 10,
          ),
          offer
              ? const Text("Offers", style: TextStyle(color: AppColor.orange))
              : const Text("Offers"),
        ],
      ),
    );
  }

  Widget profileNavbar() {
    return GestureDetector(
      onTap: () {
        if (!profile) {
          Get.toNamed('/profile');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          profile
              ? Image.asset(
                  Helper.getAssetName("user_filled.png"),
                )
              : Image.asset(
                  Helper.getAssetName("user.png"),
                ),
          const SizedBox(
            height: 10,
          ),
          profile
              ? const Text("Profile", style: TextStyle(color: AppColor.orange))
              : const Text("Profile"),
        ],
      ),
    );
  }

  Widget moreNavbar() {
    return GestureDetector(
      onTap: () {
        if (!more) {
          // Navigator.of(context)
          //     .pushReplacementNamed(MoreScreen.routeName);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          more
              ? Image.asset(
                  Helper.getAssetName("menu_filled.png"),
                )
              : Image.asset(
                  Helper.getAssetName("menu.png"),
                ),
          const SizedBox(
            height: 10,
          ),
          more
              ? const Text("Profile", style: TextStyle(color: AppColor.orange))
              : const Text("More"),
        ],
      ),
    );
  }

  Widget homeNavbar() {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: home ? AppColor.orange : AppColor.placeholder,
          onPressed: () {
            if (!home) {
              Get.toNamed('/home');
            }
          },
          child: Image.asset(Helper.getAssetName("home_white.png")),
        ),
      ),
    );
  }
}

class CustomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(
      size.width * 0.375,
      0,
      size.width * 0.375,
      size.height * 0.1,
    );
    path.cubicTo(
      size.width * 0.4,
      size.height * 0.9,
      size.width * 0.6,
      size.height * 0.9,
      size.width * 0.625,
      size.height * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.625,
      0,
      size.width * 0.7,
      0.1,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
