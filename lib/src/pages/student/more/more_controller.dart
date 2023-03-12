import 'package:fbus_app/src/global/global.dart';
import 'package:fbus_app/src/models/response_api.dart';
import 'package:fbus_app/src/providers/users_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MoreController extends GetxController {
  final storage = FlutterSecureStorage();
  UsersProviders usersProviders = UsersProviders();
  void signOut() async {
    GetStorage().remove('user');
    await storage.deleteAll();
    fAuth.signOut();
    await googleSignIn.signOut();
    Get.offNamedUntil('/splash', (route) => false);
  }

  void goToMyTicketList() async {
    String? jwtToken = await storage.read(key: 'jwtToken');
    if (jwtToken != null) {
      ResponseApi responseApi = await usersProviders.getListTicket(jwtToken);
      final data = responseApi.data;
      // List<dynamic> dataList = jsonDecode(data);
      print('ticketList ${data.length}');
      // read existing ticketList from storage
      // Invalidate the cache for 'ticketList'
      if (GetStorage().hasData('ticketList')) {
        GetStorage().remove('tickList');
      }
      GetStorage().write('ticketList', data);
      Get.toNamed('/more/my_ticket');
    }
  }
}
