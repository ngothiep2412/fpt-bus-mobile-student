import 'dart:convert';
import 'package:fbus_app/src/environment/environment.dart';
import 'package:fbus_app/src/models/response_api.dart';
import 'package:fbus_app/src/models/users.dart' as customer;
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UsersProviders extends GetConnect {
  String url = '${Environment.API_URL}api/users';

  Future<Response> create(customer.User user) async {
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

  Future<String> postUser(User user) async {
    // Uri uri = Uri.http(Environment.API_URL_OLD, '/api/users');
    // final Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    // };
    // final Map<String, dynamic> body = {
    //   'idToken': user.getIdToken(),
    // };

    // final http.Response response = await http.post(
    //   uri,
    //   headers: headers,
    //   body: jsonEncode(body),
    // );

    // Handle the response from the API
    // if (response.statusCode == 200) {
    //   final jwtToken = jsonDecode(response.body)['jwtToken'];
    //   return jwtToken;
    // } else {
    //   throw Exception('Failed to create user');
    // }
    if (true) {
      const jwtToken = 'asdasdasdasdasdasdasdasdasdasd';
      return jwtToken;
    } else {
      throw Exception('Failed to create user');
    }
  }
}
