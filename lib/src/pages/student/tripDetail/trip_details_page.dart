import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/core/helpers/image_helper.dart';
import 'package:fbus_app/src/models/station_model.dart';
import 'package:fbus_app/src/pages/student/tripDetail/trip_detail_controller.dart';
import 'package:fbus_app/src/utils/helper.dart';
import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TripDetailPage extends StatefulWidget {
  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  TripDetailController con = Get.put(TripDetailController());

  List<Station> stationList = [];

  @override
  void initState() {
    stationList = con.routeDetail.stations;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        titleString: 'Trip Detail',
        notification: false,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  quantitySeat(),
                  dateTrip(),
                  informationDriver(),
                  informationRoute(),
                  informationStation(),
                  stationList.isNotEmpty
                      ? Container(
                          height: 300, // Set a fixed height for the ListView
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: stationList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return listStation(stationList[index]);
                            },
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Center(
                            child: Text(
                              "No Station",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColor.busdetailColor,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  con.bookATrip(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.busdetailColor,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  'Book',
                  style: TextStyle(
                    fontSize: 16, // decrease font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget quantitySeat() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        margin: EdgeInsets.only(left: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Remaining Seat Count:',
                  style: TextStyle(
                    color: AppColor.text1Color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Text(
                      con.tripDetail.ticketQuantity.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.busdetailColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  Widget dateTrip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Container(
            child: Row(
              children: [
                Text(
                  'Information Date Trip:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColor.text1Color,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              ImageHelper.loadFromAsset(
                Helper.getAssetIconName('ico_calendal.png'),
              ),
              SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Date:',
                      style: TextStyle(
                        color: AppColor.busdetailColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    WidgetSpan(
                        child: SizedBox(
                      width: 10,
                    )),
                    TextSpan(
                      text: DateFormat('yyyy-MM-dd')
                          .format(con.tripDetail.departureDate),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.text1Color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              ImageHelper.loadFromAsset(
                Helper.getAssetIconName('ico_time.png'),
              ),
              SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Time :',
                      style: TextStyle(
                        color: AppColor.busdetailColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    WidgetSpan(
                        child: SizedBox(
                      width: 10,
                    )),
                    TextSpan(
                      text: con.tripDetail.departureTime,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.text1Color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget informationDriver() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Container(
            child: Row(
              children: [
                Text(
                  'Information Driver:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColor.text1Color,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              ImageHelper.loadFromAsset(
                Helper.getAssetIconName('ico_user.png'),
              ),
              SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Driver Name:',
                      style: TextStyle(
                        color: AppColor.busdetailColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    WidgetSpan(
                        child: SizedBox(
                      width: 10,
                    )),
                    TextSpan(
                      text: con.tripDetail.driverName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.text1Color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              ImageHelper.loadFromAsset(
                Helper.getAssetIconName('ico_license.png'),
              ),
              SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'License Plate :',
                      style: TextStyle(
                        color: AppColor.busdetailColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    WidgetSpan(
                        child: SizedBox(
                      width: 10,
                    )),
                    TextSpan(
                      text: con.tripDetail.licensePlate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.text1Color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget informationRoute() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Container(
            child: Row(
              children: [
                Text(
                  'Information Route:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColor.text1Color,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Departure:',
            style: TextStyle(
              color: AppColor.busdetailColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 20),
              child: Row(
                children: [
                  ImageHelper.loadFromAsset(
                      Helper.getAssetIconName('ico_location.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      con.tripDetail.departure,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.text1Color,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Destination:',
            style: TextStyle(
              color: AppColor.busdetailColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 20),
              child: Row(
                children: [
                  ImageHelper.loadFromAsset(
                      Helper.getAssetIconName('ico_location.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      con.tripDetail.destination,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.text1Color,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget informationStation() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Container(
            child: Row(
              children: [
                Text(
                  'Information Station:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColor.text1Color,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ))
    ]);
  }

  Widget listStation(Station station) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Station:',
            style: TextStyle(
              color: AppColor.busdetailColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 20),
              child: Row(
                children: [
                  ImageHelper.loadFromAsset(
                      Helper.getAssetIconName('ico_location.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      station.stationName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.text1Color,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
