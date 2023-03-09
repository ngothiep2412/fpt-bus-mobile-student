import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  // const TicketScreen({super.key});

  double? screenHeight;
  double? screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    double ticketWidth = screenWidth! * 5 / 7;
    double ticketHeight = screenHeight! * 4 / 6;

    var validColor = Colors.redAccent;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Center(
        child: Stack(children: [
          Container(
            width: ticketWidth,
            height: ticketHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              // color: Colors.orangeAccent,
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //check valid
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bus Ticket",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1.5, color: validColor)),
                        child: Row(
                          children: [
                            Image.network(
                              "https://cdn-icons-png.flaticon.com/512/262/262037.png",
                              // "https://cdn-icons-png.flaticon.com/512/157/157977.png",
                              width: 20,
                              height: 20,
                              color: validColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              // "valid",
                              "Expired",
                              style: TextStyle(
                                  color: validColor,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //trip
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text.rich(TextSpan(
                              text: "from  ",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.3),
                                  fontSize: 13),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "FPT University",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
                              ])),
                        ),
                        Image.network(
                          "https://cdn-icons-png.flaticon.com/128/1023/1023413.png",
                          width: 30,
                          height: 30,
                          color: Colors.orange,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text.rich(TextSpan(
                              text: "to  ",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.3),
                                  fontSize: 13),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Vinhome Grand Park",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
                              ])),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //in4
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: ticketWidth * 7 / 15,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Student name",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.3),
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Nguyễn Trọng Nguyên Vũ (K15 HCM)",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: ticketWidth * 4 / 15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.3),
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "24-12-2022",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: ticketWidth * 7 / 15,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Driver name",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.3),
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Nguyễn Thanh Tùng",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: ticketWidth * 4 / 15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.3),
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "12:12:12",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(4),
                      padding: EdgeInsets.all(6),
                      child: Text("51B-273-39"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.network(
                      "https://pngimg.com/uploads/qr_code/qr_code_PNG26.png",
                      width: 120,
                      height: 120,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: ticketHeight / 2 - 20,
              left: -20,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
              )),
          Positioned(
              top: ticketHeight / 2 - 20,
              right: -20,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
              )),
        ]),
      )),
    );
  }
}
