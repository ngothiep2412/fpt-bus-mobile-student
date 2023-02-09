import 'package:fbus_app/src/assets/constant.dart';
import 'package:fbus_app/src/pages/tabPages/home_tab.dart';
import 'package:fbus_app/src/pages/tabPages/notification_tab.dart';
import 'package:fbus_app/src/pages/tabPages/profile_tab.dart';
import 'package:fbus_app/src/pages/tabPages/ticket_tab.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeTabPage(),
          NotificationTabPage(),
          ProfileTabPage(),
          TicketTabPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/logo/home.png',
              color: selectedIndex == 0 ? primary : kgrey,
              height: 30,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/logo/ticket.png',
              color: selectedIndex == 1 ? primary : kgrey,
              height: 30,
            ),
            label: "My Tickets",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/logo/notification.png',
              color: selectedIndex == 2 ? primary : kgrey,
              height: 30,
            ),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/logo/profile.png',
              color: selectedIndex == 3 ? primary : kgrey,
              height: 30,
            ),
            label: "Profile",
          ),
        ],
        selectedItemColor: primary,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}
