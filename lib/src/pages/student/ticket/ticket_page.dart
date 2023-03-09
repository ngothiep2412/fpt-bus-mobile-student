import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/pages/student/notifications/notification_page.dart';
import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late List<PushNotification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = []; // initialize the list here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        titleString: 'My Ticket',
        implementLeading: false,
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 20.0, top: 20, bottom: 20),
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: NotificationBadge(totalNotifications: _totalNotifications),
          //   ),
          // ),
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
                    child: Text('No tickets'),
                  ),
          ),
        ],
      ),
    );
  }
}
