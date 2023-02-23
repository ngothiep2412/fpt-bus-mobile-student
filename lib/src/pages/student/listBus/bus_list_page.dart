import 'package:fbus_app/src/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';

class BusListPage extends StatelessWidget {
  const BusListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        implementLeading: true,
        titleString: "List the bus",
      ),
      body: SafeArea(child: Container()),
    );
  }
}
