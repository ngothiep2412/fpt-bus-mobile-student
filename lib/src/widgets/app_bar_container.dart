import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/core/helpers/image_helper.dart';
import 'package:fbus_app/src/utils/helper.dart';
import 'package:fbus_app/src/widgets/custom_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CustomAppBar extends AppBar {
  final String? titleString;
  final String? subTitleString;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? trailingOnPressed;
  final VoidCallback? logoutOnPressed;
  final bool implementLeading;
  final bool implementTrailing;
  final BuildContext context;
  final bool logout;

  CustomAppBar({
    Key? key,
    this.titleString,
    this.subTitleString,
    this.leadingOnPressed,
    this.trailingOnPressed,
    this.logoutOnPressed,
    required this.context,
    this.logout = true,
    this.implementLeading = true,
    this.implementTrailing = true,
  }) : super(
          key: key,
          title: titleString != null
              ? Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleString,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textColor,
                          ),
                        ),
                        subTitleString != null
                            ? const SizedBox(
                                height: 10,
                              )
                            : SizedBox(),
                        subTitleString != null
                            ? Text(
                                subTitleString,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.textColor,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    Spacer(),
                    !logout
                        ? GestureDetector(
                            onTap: () {
                              Get.toNamed('/navigation/home/notifications');
                            },
                            child: NotificationIcon(notificationCount: 1),
                          )
                        : GestureDetector(
                            onTap: logoutOnPressed ?? () {},
                            child: Row(
                              children: [
                                Icon(
                                  Ionicons.log_out,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                )
              : null,
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 140,
          backgroundColor: AppColor.backgroundScaffoldColor,
          leading: implementLeading
              ? Row(
                  children: [
                    GestureDetector(
                      onTap:
                          leadingOnPressed ?? () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Ionicons.arrow_back,
                            size: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : null,
          actions: implementTrailing
              ? [
                  GestureDetector(
                    onTap: trailingOnPressed ?? () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      // padding: EdgeInsets.all(10.0),
                      // child: Icon(
                      //   Ionicons.bar_chart,
                      //   size: 24,
                      //   color: Colors.black,
                      // ),
                    ),
                  ),
                ]
              : null,
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 231, 131, 77),
                      Color.fromARGB(255, 225, 109, 54)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: ImageHelper.loadFromAsset(
                  Helper.getAssetIconName('ico_oval_top.png'),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ImageHelper.loadFromAsset(
                  Helper.getAssetIconName('ico_oval_bottom.png'),
                ),
              ),
            ],
          ),
        );
}
