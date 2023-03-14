import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/core/const/promotion.dart';
import 'package:fbus_app/src/pages/student/home/home_controller.dart';
import 'package:fbus_app/src/theme/colors.dart';
import 'package:fbus_app/src/theme/padding.dart';
import 'package:fbus_app/src/widgets/custom_course_card.dart';
import 'package:fbus_app/src/widgets/custom_promotion_card.dart';
import 'package:fbus_app/src/widgets/custom_search_field.dart';
import 'package:fbus_app/src/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController con = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        body: Obx(
          () => getBody(),
        ));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: spacer),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipPath(
                clipper: BottomClipper(),
                child: Container(
                    width: size.width,
                    height: 300.0,
                    decoration: BoxDecoration(
                      color: AppColor.busdetailColor,
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: appPadding, right: appPadding),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50 + 24),

                    //heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomHeading(
                          title: 'Hi, ${con.user.value.fullname}!',
                          subTitle: 'Let\'s start booking.',
                          color: Color(0xFFFFFFFF),
                        ),
                        Container(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                                // borderRadius: BorderRadius.circular(100),
                                // child: Image.asset(
                                //   UserProfile['image'].toString(),
                                //   fit: BoxFit.cover,
                                // )
                                )),
                      ],
                    ),
                    SizedBox(height: spacer),

                    //search
                    CustomSearchField(
                      hintField: 'Search your Trip',
                      backgroundColor: background,
                    ),
                    SizedBox(height: spacer - 30.0),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          //promotion card
          CustomPromotionCard(),
          SizedBox(height: spacer),

          //feature courses

          //feature category
          Padding(
            padding: const EdgeInsets.only(left: appPadding, right: appPadding),
            child: CustomTitle(title: "Today's Trip"),
          ),
          SizedBox(height: smallSpacer),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: appPadding,
              right: appPadding - 10.0,
            ),
            child: Wrap(
              children: List.generate(CoursesJson.length, (index) {
                var data = CoursesJson[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 15.0, bottom: 20.0),
                  child: GestureDetector(
                    child: CustomCourseCardExpand(
                      thumbNail: data['image'],
                      videoAmount: data['video'],
                      title: data['title'],
                      userProfile: data['user_profile'],
                      userName: data['user_name'],
                      price: data['price'],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width - size.width / 4, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomHeading extends StatelessWidget {
  const CustomHeading({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.color,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          subTitle,
          style: TextStyle(
            color: color,
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
