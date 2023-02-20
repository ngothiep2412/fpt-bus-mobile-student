import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../const/colors.dart';
import '../../models/response_api.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';

UserModel userSession = UserModel.fromJson(GetStorage().read('user') ?? {});
FlutterSecureStorage storage = FlutterSecureStorage();

class ProfileController extends GetxController {
  TextEditingController nameController =
      TextEditingController(text: userSession.fullname);
  TextEditingController phoneController =
      TextEditingController(text: userSession.phoneNumber);

  ImagePicker picker = ImagePicker();
  File? imageFile;
  UsersProviders usersProviders = UsersProviders();

  // *TODO Create a function to update the profile.
  // !Bug 02:When we are upading profile user it need to save in getStorage and ovveride user before
  void save() async {
    String name = nameController.text;
    String phone = phoneController.text;
    // String? jwtToken = await storage.read(key: 'jwtToken');
    print('imageFile $imageFile');
    List<int> imageBytes = await imageFile!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print('base64Image $base64Image');
    final box = GetStorage();
    // String? jwtToken = await storage.read(key: 'jwtToken');
    String jwtToken = box.read('jwtToken');
    if (isValidForm() && jwtToken != null) {
      ResponseApi responseApi = await usersProviders.updateProfilePicture(
          userSession, base64Image, jwtToken);
      // final data = responseApi['data'];
      if (responseApi.data != null) {
        Get.snackbar("Successfully", "Updated image fully");
      }
    }
  }

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

  bool isValidForm() {
    // if (phone.isEmpty) {
    //   Get.snackbar('Invalid from', 'You must enter your phone');
    //   return true;
    // }
    // if (phoneExp.hasMatch(phone) == false) {
    //   Get.snackbar('Invalid from', 'You must enter number');
    //   return false;
    // }
    if (imageFile == null) {
      Get.snackbar('Error', 'You must choose your image');
      return false;
    }
    return true;
  }
}
