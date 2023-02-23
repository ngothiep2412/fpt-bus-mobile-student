import 'dart:convert';
import 'package:fbus_app/src/environment/environment.dart';
import 'package:fbus_app/src/models/response_api.dart';
import 'package:fbus_app/src/models/users.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersProviders extends GetConnect {
  String url = '${Environment.API_URL}api/users';

  Future<ResponseApi> loginGoogle(String token) async {
    // String token = await user.getIdToken();
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/v1/auth/sign-in');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> body = {
      'accessToken': token,
    };

    final http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    // Handle the response from the API
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<ResponseApi> updateProfilePicture(
      UserModel user, String base64Image, String jwtToken) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/v1/upload-file');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwtToken',
    };

    final Map<String, dynamic> body = {
      'type': 'profile',
      'imageBase64': "data:image/jpeg;base64,$base64Image",
      'userId': user.id,
    };

    final http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } else {
      throw Exception('Failed to update profile picture');
    }
  }

  Future<void> uploadNotification(
      String token, String title, String comment, String jwtToken) async {
    // Define the API endpoint
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/v1/notification');

    // Create the request headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwtToken',
    };

    // Create the request body
    Map<String, dynamic> body = {
      'token': token,
      'title': title,
      'content': comment,
    };

    // Send the POST request to the API endpoint
    final response =
        await http.post(uri, headers: headers, body: jsonEncode(body));

    // Check the response status code
    if (response.statusCode == 200) {
      print('Notification uploaded successfully');
    } else {
      throw Exception('Failed to upload notification');
    }
  }
}
