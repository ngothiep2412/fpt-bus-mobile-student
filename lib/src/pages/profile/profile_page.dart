import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:transparent_image/transparent_image.dart';

import './../../const/colors.dart';
import './../../models/users.dart';
import './../../pages/profile/profile_controller.dart';
import './../../widgets/custom_form_input.dart';
import './../../widgets/custom_navbar.dart';
import './../../utils/helper.dart';

UserModel userSession = UserModel.fromJson(GetStorage().read('user') ?? {});

class ProfilePage extends StatelessWidget {
  ProfileController con = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      _topNavbar(),
                      const SizedBox(
                        height: 50,
                      ),
                      _imageProfile(context),
                      const SizedBox(
                        height: 10,
                      ),
                      _editImage(),
                      const SizedBox(
                        height: 10,
                      ),
                      _textWelcome(),
                      const SizedBox(
                        height: 10,
                      ),
                      _textEmail(),
                      const SizedBox(
                        height: 45,
                      ),
                      CustomFormInput(
                        label: "Name",
                        isPassword: false,
                        controller: con.nameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormInput(
                        label: "Mobile No",
                        isPassword: false,
                        controller: con.phoneController,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      _btnSave()
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              profile: true,
            ),
          ),
        ],
      ),
    );
  }

  // *TODO

  Widget _topNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text(
          "Profile",
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.normal,
            fontSize: 25,
          ),
        ),
      ],
    );
  }

  Widget _imageProfile(BuildContext context) {
    return ClipOval(
      child: Stack(
        children: [
          Container(
            height: 80,
            width: 80,
            child: GetBuilder<ProfileController>(
              builder: (value) => con.imageFile != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(con.imageFile!),
                    )
                  : userSession.profileImg != null
                      ? FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: userSession.profileImg ?? '',
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          Helper.getAssetName(
                            "user.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 20,
              width: 80,
              color: Colors.black.withOpacity(0.3),
              child: GestureDetector(
                onTap: () => con.showAlertDialog(context),
                child: Image.asset(Helper.getAssetName("camera.png")),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _editImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Helper.getAssetName("edit_filled.png"),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          "Edit Profile",
          style: TextStyle(color: AppColor.orange),
        ),
      ],
    );
  }

  Widget _textWelcome() {
    return const Text(
      "Welcome",
      style: TextStyle(
        color: AppColor.secondary,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget _textEmail() {
    return Text(
      "${userSession.email}",
      style: const TextStyle(
        color: AppColor.secondary,
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
    );
  }

  Widget _btnSave() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => con.save(),
        child: const Text(
          "Save",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
