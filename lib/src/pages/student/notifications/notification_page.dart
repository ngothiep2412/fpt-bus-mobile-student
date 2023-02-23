import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        implementLeading: true,
        titleString: "My Notification",
        logout: false,
      ),
      body: SafeArea(child: Container()),
    );
  }
}
