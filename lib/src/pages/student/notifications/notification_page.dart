import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/pages/student/notifications/notification_badge.dart';
import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<PushNotification> _notifications;
  late int _totalNotifications;
  late final FirebaseMessaging _messaging;

  // Hàm này sẽ được gọi khi nhận được thông báo từ Firebase
  void _onMessageReceived(RemoteMessage message) {
    PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      dataTitle: message.data['title'],
      dataBody: message.data['body'],
      sentTime: message.sentTime.toString(),
    );
    setState(() {
      _notifications.add(notification);
      _notifications.sort((a, b) => b.sentTime!.compareTo(a.sentTime!));
      _totalNotifications++;
    });
    // Check if the app is currently in the foreground
    // if (message.notification != null &&
    //     message.notification!.title != null &&
    //     message.notification!.body != null) {
    //   if (message.notification!.title!.isNotEmpty &&
    //       message.notification!.body!.isNotEmpty) {
    //     // App is in foreground, show a dialog to notify the user
    //     showDialog(
    //       context: context,
    //       builder: (_) => AlertDialog(
    //         title: Text(message.notification!.title!),
    //         content: Text(message.notification!.body!),
    //         actions: [
    //           TextButton(
    //             child: Text('OK'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //               Navigator.of(context)
    //                   .pushNamed('/navigation/home/notifications');
    //             },
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    // }
  }

  @override
  void initState() {
    super.initState();
    _notifications = [];
    _totalNotifications = 0;
    FirebaseMessaging.onMessage.listen(_onMessageReceived);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageReceived);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _messaging = FirebaseMessaging.instance;
    checkForInitialMessage();
  }

  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    print('NOTIFICATION DATE: ${initialMessage?.sentTime}');
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        sentTime: initialMessage.sentTime.toString(),
      );
      setState(() {
        _notifications.add(notification);
        _notifications.sort((a, b) => b.sentTime!.compareTo(a.sentTime!));
        _totalNotifications++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        titleString: 'Notifications',
        implementLeading: true,
        notification: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 20, bottom: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: NotificationBadge(totalNotifications: _totalNotifications),
            ),
          ),
          Expanded(
            child: _notifications.isNotEmpty
                ? ListView.builder(
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      PushNotification notification = _notifications[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.busdetailColor,
                              ),
                              child: Icon(
                                Ionicons.notifications,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(notification.title ?? ''),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(notification.body ?? ''),
                                SizedBox(height: 10),
                                Text(
                                  DateFormat('dd/MM/yyyy HH:mm').format(
                                      DateTime.parse(notification.sentTime!)),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text('No notifications'),
                  ),
          ),
        ],
      ),
    );
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
    this.sentTime,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
  String? sentTime;
}
