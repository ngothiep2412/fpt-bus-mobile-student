import 'package:fbus_app/src/environment/environment.dart';
import 'package:fbus_app/src/models/response_api.dart';
import 'package:fbus_app/src/models/users.dart';
import 'package:get/get.dart';

class UsersProviders extends GetConnect {
  String url = '${Environment.API_URL}api/users';

  Future<Response> create(User user) async {
    Response response = await post(
      '$url/create',
      user.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    return response;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
      '$url/login',
      {
        'email': email,
        'password': password,
      },
      headers: {'Content-Type': 'application/json'},
    );

    if (response.body == null) {
      Get.snackbar("Error", 'Request could not excute');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
