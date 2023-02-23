import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NotificationIcon extends StatelessWidget {
  final int notificationCount;

  const NotificationIcon({Key? key, this.notificationCount = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            print('Notifications');
          },
          child: Icon(
            Ionicons.notifications,
            color: Colors.white,
            size: 30,
          ),
        ),
        if (notificationCount > 0)
          Positioned(
            left: 12,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                notificationCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
