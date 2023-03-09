import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/core/helpers/image_helper.dart';
import 'package:fbus_app/src/pages/student/home/home_controller.dart';
import 'package:fbus_app/src/utils/helper.dart';
import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:fbus_app/src/widgets/custom_dropdown.dart';
import 'package:fbus_app/src/widgets/item_button_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController con = Get.put(HomeController());

  @override
  void dispose() {
    con.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleString: "Hi, ${con.user.value.fullname}",
        context: context,
        implementLeading: false,
        subTitleString: "What are you looking for next?",
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          Helper.getAssetName("fbus.png"),
                          height: 200,
                          width: 310,
                        ),
                        Positioned(
                          bottom: 12,
                          top: 166,
                          left: 0,
                          right: 0,
                          child: Divider(
                            height: 1,
                            thickness: 2,
                            color: Color.fromARGB(255, 238, 180, 94),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomDropdown(
                      controller: con.routeTextEditting,
                      text: "Route",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2100, 12, 31),
                          onConfirm: (date) {
                            setState(() {
                              con.selectedDate = date;
                            });
                          },
                          currentTime: con.selectedDate ?? DateTime.now(),
                          locale: LocaleType.en,
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(bottom: 24),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: ImageHelper.loadFromAsset(
                                  Helper.getAssetIconName('ico_calendal.png'),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select date",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF323B4B),
                                      fontWeight: FontWeight.w400,
                                      height: 16 / 14,
                                    ).copyWith(
                                      fontSize: 14,
                                      height: 12 / 10,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    con.selectedDate == null
                                        ? 'Select Date'
                                        : '${con.selectedDate?.year}-${con.selectedDate?.month}-${con.selectedDate?.day}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF323B4B),
                                      fontWeight: FontWeight.w400,
                                      height: 16 / 14,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(height: 10),
                    ItemButtonWidget(
                      data: 'Search the bus',
                      color: Colors.white,
                      onTap: () {
                        con.searchTheBus(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
