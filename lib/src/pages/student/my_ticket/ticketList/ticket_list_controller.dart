import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/models/llist_ticket_model.dart';
import 'package:fbus_app/src/models/response_api.dart';
import 'package:fbus_app/src/pages/student/tripDetail/trip_detail_controller.dart';
import 'package:fbus_app/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class TicketListController extends GetxController {
  List<dynamic> rawList = GetStorage().read('ticketList');
  UsersProviders usersProviders = UsersProviders();
  void handleTicketSelection(String ticketId, BuildContext context) async {
    String? jwtToken = await storage.read(key: 'jwtToken');
    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(
      max: 200,
      msg: 'Loading.....',
      progressValueColor: Colors.white,
      progressBgColor: AppColor.orange,
      // msgColor: Colors.black,
    );
    if (jwtToken != null) {
      try {
        ResponseApi responseApi =
            await usersProviders.getMyTicketDetail(jwtToken, ticketId);
        final dataTicket = responseApi.data;
        progressDialog.close();
        // print('DATATICKET: ${dataTicket['Trip']['Route']['destination']}');
        if (GetStorage().hasData('myTicketDetail')) {
          GetStorage().remove('myTicketDetail');
        }
        GetStorage().write('myTicketDetail', dataTicket);

        Get.toNamed('/more/my_ticket/my_ticket_detail');
      } catch (e) {
        Get.snackbar("ERROR", "SERVER");
      }
    }
  }
}
