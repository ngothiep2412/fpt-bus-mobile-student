import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';

class BusListPage extends StatelessWidget {
  // const BusListPage({super.key});

  List users = ["1", "2", "3", "4", "5"];

  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        implementLeading: true,
        titleString: "List the bus",
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
                  height: 30,
                ),
                const Text(
                  "Choose your trip",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: users.length,
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
      onTap: () {},
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
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Departure
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icon/ico_location_bus_list.png",
                          width: 22,
                          height: 22,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Vinhomes Grand Park",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    //Destination
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icon/ico_flag_bus_list.png",
                          width: 22,
                          height: 22,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "University of Transportation",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
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
                            Image.asset(
                              "assets/icon/ico_schedule_bus_list.png",
                              width: 20,
                              height: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  "12:12:12",
                                  style: TextStyle(fontSize: 16),
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
                                "assets/icon/ico_bus_list.png",
                                width: 40,
                                height: 40,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "51A-099.99",
                                style: TextStyle(fontSize: 16),
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
                      color: Colors.green,
                      width: 2,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "45",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                      Text(
                        "seats",
                        style: TextStyle(
                            color: Colors.black45,
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
