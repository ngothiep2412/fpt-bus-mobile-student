import 'package:dotted_line/dotted_line.dart';
import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/models/llist_ticket_model.dart';
import 'package:fbus_app/src/pages/student/my_ticket/ticketList/ticket_list_controller.dart';
import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketListPage extends StatefulWidget {
  @override
  State<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage> {
  // const TicketListPage({super.key});
  TicketListController con = Get.put(TicketListController());

  double screenHeight = 0;

  double screenWidth = 0;

  var backgroundColor = Color.fromARGB(255, 229, 228, 234);
  List<ListTicketModel> ticketList = [];
  @override
  void initState() {
    super.initState();
    ticketList =
        con.rawList.map((item) => ListTicketModel.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        titleString: 'My Ticket',
        implementLeading: true,
        notification: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ListView.builder(
          itemCount: ticketList.length,
          itemBuilder: (context, index) {
            return item(index);
          },
        ),
      )),
    );
  }

  Widget item(int index) {
    const marginHorizontal = 20.0;
    return GestureDetector(
      onTap: () {
        con.handleTicketSelection(ticketList[index].id, context);
      },
      child: Container(
        width: screenWidth,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: 30, left: marginHorizontal, right: marginHorizontal),
        child: Row(
          children: [
            Container(
              width: screenWidth * 2 / 7,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              // color: Colors.grey.withOpacity(0.1),
              child: Container(
                // margin: EdgeInsets.only(right: 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      ticketList[index].qrUrl,
                      width: (screenWidth * 2 / 7) * 0.9,
                      height: (screenWidth * 2 / 7) * 0.9,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                    ),
                  ),
                  DottedLine(
                    direction: Axis.vertical,
                    dashColor: AppColor.busdetailColor.withOpacity(0.2),
                    lineLength: 170,
                    lineThickness: 5,
                  ),
                  Container(
                    width: 30,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth -
                  (screenWidth * 2 / 7) -
                  30 -
                  marginHorizontal * 2,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     offset: Offset(10, 0),
                //     blurRadius: 10.0,
                //     spreadRadius: 0.2,
                //   ),
                // ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Departure Time",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.text1Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        ticketList[index].trip.departureTime,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Departure",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.text1Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        ticketList[index].trip.route.departure,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Destination",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.text1Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        ticketList[index].trip.route.destination,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
