import 'dart:io';
import 'dart:convert';
import 'package:fbus_app/src/core/const/colors.dart';
import 'package:fbus_app/src/models/response_api.dart';
import 'package:fbus_app/src/models/users.dart';
import 'package:fbus_app/src/providers/users_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

UserModel userSession = UserModel.fromJson(GetStorage().read('user') ?? {});
FlutterSecureStorage storage = FlutterSecureStorage();

class UpdateProfileController extends GetxController {
  TextEditingController nameController =
      TextEditingController(text: userSession.fullname);
  TextEditingController phoneController =
      TextEditingController(text: userSession.phoneNumber);

  final RegExp phoneExp = RegExp(r'^[0-9]+$');

  ImagePicker picker = ImagePicker();
  File? imageFile;
  UsersProviders usersProviders = UsersProviders();

  void updateInfo(BuildContext context) async {
    String name = nameController.text;
    String phone = phoneController.text;

    if (isValidForm(name, phone)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);

      progressDialog.show(
        max: 200,
        msg: 'Updating data...',
        progressValueColor: Colors.white,
        progressBgColor: AppColor.orange,
        // msgColor: Colors.black,
      );

      UserModel myUser = UserModel(
        email: userSession.email,
        fullname: userSession.fullname,
        id: userSession.id,
        phoneNumber: userSession.phoneNumber,
        profileImg: userSession.profileImg,
        roleName: userSession.roleName,
        status: userSession.status,
        studentId: userSession.studentId,
      );
      if (imageFile == null) {
        await Future.delayed(Duration(milliseconds: 500));
        // api
        // Get.snackbar('Finished process', responseApi.message ?? '');
        progressDialog.close();
        Get.toNamed('/navigation');
      } else {
        // String? jwtToken = await storage.read(key: 'jwtToken');
        List<int> imageBytes = await imageFile!.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        print('base64Image $base64Image');
        final box = GetStorage();
        // String? jwtToken = await storage.read(key: 'jwtToken');
        String jwtToken = box.read('jwtToken');
        ResponseApi responseApi = await usersProviders.updateProfilePicture(
            userSession, base64Image, jwtToken);
        // final data = responseApi['data'];
        if (responseApi.data != null) {
          Get.snackbar("Successfully", "Updated image fully");
        }
      }
    }
  }

  // void updateWithImage() async {
  //   // String? jwtToken = await storage.read(key: 'jwtToken');
  //   List<int> imageBytes = await imageFile!.readAsBytes();
  //   String base64Image = base64Encode(imageBytes);
  //   print('base64Image $base64Image');
  //   final box = GetStorage();
  //   // String? jwtToken = await storage.read(key: 'jwtToken');
  //   String jwtToken = box.read('jwtToken');
  //     ResponseApi responseApi = await usersProviders.updateProfilePicture(
  //         userSession, base64Image, jwtToken);
  //     // final data = responseApi['data'];
  //     if (responseApi.data != null) {
  //       Get.snackbar("Successfully", "Updated image fully");
  //     }
  //   }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      File selectedFile = File(image.path);
      if (selectedFile.lengthSync() < 1000000 * 50) {
        imageFile = selectedFile;
        update();
      } else {
        Get.snackbar("Error", "Your image size is too large");
      }
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      },
      child: const Text(
        'Gallery',
        style: TextStyle(color: AppColor.textColor),
      ),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
      },
      child: const Text(
        'Camera',
        style: TextStyle(color: AppColor.textColor),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text(
        'Select an option',
        style: TextStyle(color: AppColor.primary),
        textAlign: TextAlign.center,
      ),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  bool isValidForm(
    String fullname,
    String phone,
  ) {
    if (phone.isEmpty) {
      Get.snackbar('Invalid from', 'You must enter your phone');
      return true;
    } else {
      if (phoneExp.hasMatch(phone) == false) {
        Get.snackbar('Invalid from', 'You must enter number');
        return false;
      }
    }

    if (fullname.isEmpty) {
      Get.snackbar('Invalid from', 'You must enter number');
      return false;
    }
    return true;
  }
}
