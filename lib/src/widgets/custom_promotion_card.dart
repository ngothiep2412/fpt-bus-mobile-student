import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/const/promotion.dart';
import '../theme/colors.dart';
import '../theme/padding.dart';

class CustomPromotionCard extends StatefulWidget {
  const CustomPromotionCard({Key? key}) : super(key: key);

  @override
  State<CustomPromotionCard> createState() => _CustomPromotionCardState();
}

class _CustomPromotionCardState extends State<CustomPromotionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late DateTime destinationTime;

  @override
  void initState() {
    super.initState();
    destinationTime = DateTime.now().add(Duration(minutes: 2));
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60 * 10), // 10 minutes
    )..reverse(from: 1.0); // start the animation from the end
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: appPadding, right: appPadding),
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size.width,
            height: size.width * .465,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GET A BUS',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: textWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 7.0),
                Container(
                  width: size.width * .425,
                  child: Text(
                    'Name Route: Tuyến 3',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: textWhite,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 7.0),
                Container(
                  width: size.width * .425,
                  child: Text(
                    'DATE: 2023-03-11',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: textWhite,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 7.0),
                setTimeLeft(size),
                Spacer(),
                SizedBox(height: 7.0),
                Container(
                  height: 35.0,
                  width: 100.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(0.5),
                        spreadRadius: 0.0,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Text(
                    'Go Now',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: textWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -20.0,
            right: 20.0,
            child: Container(
              height: size.width * .4,
              child: SvgPicture.asset(
                Promotion['image'].toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget setTimeLeft(Size size) {
    Duration difference = destinationTime.difference(DateTime.now());
    if (difference.inSeconds <= 0) {
      _controller.stop();
      return Container(
        width: size.width * .425,
        child: Text(
          "Time's up!",
          style: TextStyle(
            fontSize: 15.0,
            color: textWhite,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    int minutes = difference.inMinutes;
    int seconds = difference.inSeconds % 60;
    String timeLeft =
        "Time left: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: size.width * .425,
          child: Text(
            timeLeft,
            style: TextStyle(
              fontSize: 15.0,
              color: textWhite,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
    );
  }
}
