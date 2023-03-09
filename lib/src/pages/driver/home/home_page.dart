import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/pages/driver/notification/notifications_page.dart';
import 'package:fbus_app/src/widgets/my_drawer_header.dart';
import 'package:flutter/material.dart';

class HomaeDriverPage extends StatefulWidget {
  @override
  _HomaeDriverPageState createState() => _HomaeDriverPageState();
}

class _HomaeDriverPageState extends State<HomaeDriverPage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.contacts) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.events) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.notes) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.settings) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.notifications) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.privacyPolicy) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.sendFeedback) {
      container = NotificationsPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orange
            .withAlpha(255)
            .withRed(225)
            .withGreen(109)
            .withBlue(54),
        toolbarHeight: 120,
        title: Text(
          "F-BUS",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Contacts", Icons.people_alt_outlined,
              currentPage == DrawerSections.contacts ? true : false),
          menuItem(3, "Events", Icons.event,
              currentPage == DrawerSections.events ? true : false),
          menuItem(4, "Notes", Icons.notes,
              currentPage == DrawerSections.notes ? true : false),
          Divider(),
          menuItem(5, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Notifications", Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false),
          Divider(),
          menuItem(7, "Privacy policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacyPolicy ? true : false),
          menuItem(8, "Send feedback", Icons.feedback_outlined,
              currentPage == DrawerSections.sendFeedback ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.contacts;
            } else if (id == 3) {
              currentPage = DrawerSections.events;
            } else if (id == 4) {
              currentPage = DrawerSections.notes;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.notifications;
            } else if (id == 7) {
              currentPage = DrawerSections.privacyPolicy;
            } else if (id == 8) {
              currentPage = DrawerSections.sendFeedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  contacts,
  events,
  notes,
  settings,
  notifications,
  privacyPolicy,
  sendFeedback,
}
