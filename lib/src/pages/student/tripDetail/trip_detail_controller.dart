import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/models/response_api.dart';
import 'package:fbus_app/src/models/route_model.dart';
import 'package:fbus_app/src/models/ticket_model.dart';
import 'package:fbus_app/src/models/trip_model.dart';
import 'package:fbus_app/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

FlutterSecureStorage storage = FlutterSecureStorage();

class TripDetailController extends GetxController {
  UsersProviders usersProviders = UsersProviders();
  RouteModel routeDetail = GetStorage().read('routeDetail');
  TripModel tripDetail = TripModel.fromJson(GetStorage().read('tripDetail'));

  void bookATrip(BuildContext context) async {
    String? jwtToken = await storage.read(key: 'jwtToken');
    if (jwtToken != null) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(
        max: 200,
        msg: 'Loading.....',
        progressValueColor: Colors.white,
        progressBgColor: AppColor.orange,
        // msgColor: Colors.black,
      );
      try {
        String? tripID = GetStorage().read('tripDetailID');
        print('TRIP + ID: $tripID');
        if (tripID != null) {
          TicketModel ticket = await usersProviders.getTicket(jwtToken, tripID);
          if (ticket != null) {
            progressDialog.close();
            String tripId = "TRIP_${tripDetail.id}";
            await usersProviders.subScribeToTripTopic(tripId);
            ResponseApi responseApi =
                await usersProviders.getListTicket(jwtToken);
            final data = responseApi.data;
            // List<dynamic> dataList = jsonDecode(data);
            print('ticketList ${data.length}');
            // read existing ticketList from storage
            // Invalidate the cache for 'ticketList'
            if (GetStorage().hasData('ticketList')) {
              GetStorage().remove('tickList');
            }
            GetStorage().remove('tripDetailID');
            GetStorage().write('ticketList', data);
            GetStorage().write('ticket', ticket);
            progressDialog.close();
            Get.toNamed('/navigation/search_trip/trip_detail/booking');
            // }
          }
        }
      } catch (e) {
        progressDialog.close();
      }
    }
  }
}
