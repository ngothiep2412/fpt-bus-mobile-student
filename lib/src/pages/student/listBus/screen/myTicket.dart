import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class MyTicket extends StatelessWidget {
  // const MyTicket({super.key});

  double screenHeight = 0;
  double screenWidth = 0;
  var backgroundColor = Color.fromARGB(255, 229, 228, 234);

  List tickets = ["1", "2", "3", "4", "5"];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            return item(index);
          },
        ),
      )),
    );
  }

  Widget item(int index) {
    const marginHorizontal = 20.0;
    return Container(
      width: screenWidth,
      height: 180,
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
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            // color: Colors.grey.withOpacity(0.1),
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Qr_code_wiktionary_link.svg/800px-Qr_code_wiktionary_link.svg.png',
                    width: (screenWidth * 2 / 7) * 0.8,
                    height: (screenWidth * 2 / 7) * 0.8,
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
                  height: 15,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                ),
                DottedLine(
                  direction: Axis.vertical,
                  dashColor: Colors.black.withOpacity(0.2),
                  lineLength: 150,
                  lineThickness: 3,
                ),
                Container(
                  width: 30,
                  height: 15,
                  decoration: BoxDecoration(
                    color: backgroundColor,
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
            width:
                screenWidth - (screenWidth * 2 / 7) - 30 - marginHorizontal * 2,
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
                Text(
                  "Title",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Journey Start",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "12:12:12",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "From",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "Vinhome Grand Park",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "To",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "Vinhome Grand Park",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
