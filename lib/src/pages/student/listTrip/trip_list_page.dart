import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/core/helpers/image_helper.dart';
import 'package:fbus_app/src/pages/student/listTrip/trip_list_controller.dart';
import 'package:fbus_app/src/utils/helper.dart';
import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripListPage extends StatefulWidget {
  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  TripListController con = Get.put(TripListController());

  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        implementLeading: true,
        titleString: "List The Bus",
        notification: false,
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xfff2f2f2),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 25,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: con.trips.length,
                  itemBuilder: (context, index) {
                    return itemListView(index);
                  },
                ),
                // const SizedBox(
                //   height: 50,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemListView(int index) {
    return GestureDetector(
      onTap: () {
        con.handleTripSelection(index, context);
      },
      child: AnimatedContainer(
        height: 180,
        width: screenWidth,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300 + (index * 200)),
        // transform:
        // Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: screenWidth,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Departure
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageHelper.loadFromAsset(
                            Helper.getAssetIconName('ico_location.png')),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          con.trips[index].departure,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.text1Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //Destination
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageHelper.loadFromAsset(
                            Helper.getAssetIconName('ico_location.png')),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          con.trips[index].destination,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.text1Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(),

                    //Time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Time
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ImageHelper.loadFromAsset(
                                Helper.getAssetIconName('ico_calendal.png')),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 2,
                                      color: AppColor.busdetailColor)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  con.trips[index].departureTime,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.text1Color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //License
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icon/ico_bus.png",
                                width: 36,
                                height: 36,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                con.trips[index].licensePlate,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.text1Color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 15,
              right: 15,
              //Seat
              child: Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.busdetailColor,
                      width: 2,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        con.trips[index].ticketQuantity.toString(),
                        style: TextStyle(
                            color: AppColor.busdetailColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                      Text(
                        "seats",
                        style: TextStyle(
                            color: AppColor.text1Color,
                            fontWeight: FontWeight.w400,
                            fontSize: 11),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
