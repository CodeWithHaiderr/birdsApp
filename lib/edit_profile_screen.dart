import 'dart:io';

import 'package:birdz_app/controller/profile_controller.dart';
import 'package:birdz_app/widgets/custom_textfield.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'consts/lists.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent.shade400,
          title: const Text(
            'Edit Profile',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // if ImageUrl in firebase table and controller path is null or empty
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      cockatiel,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  // if data is not empty but controller path is empty
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      // if both are empty
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              ElevatedButton(
                  onPressed: () {
                    controller.changeImage(context);
                  },
                  child: const Text('Change Image')),
              const SizedBox(
                height: 20,
              ),
              customTextField(
                  controller: controller.nameeController,
                  hint: "Name",
                  isPass: false),
              const SizedBox(
                height: 10,
              ),
              customTextField(
                  controller: controller.oldPassController,
                  hint: "Enter Old Password",
                  isPass: true),
              const SizedBox(
                height: 10,
              ),
              customTextField(
                  controller: controller.newPassController,
                  hint: "Enter New Password",
                  isPass: true),
              const SizedBox(
                height: 20,
              ),
              controller.isLoading.value
                  ? loadingIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        controller.isLoading(true);

                        //if image is not selected
                        if (controller.profileImgPath.value.isNotEmpty) {
                          await controller.uploadProfileImage();
                        } else {
                          controller.profileImageLink = data['imageUrl'];
                        }

                        //condition for matching old password with the password field of database
                        if (data['password'] ==
                            controller.oldPassController.text) {
                          await controller.changeAuthPassword(
                            email: data['email'],
                            password: controller.oldPassController.text,
                            newpassword: controller.newPassController.text,
                          );

                          await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameeController.text,
                            password: controller.newPassController.text,
                          );
                          VxToast.show(context,
                              msg: "Changings Saved",
                              bgColor: Colors.green.shade500,
                              textColor: Colors.white);
                        } else if (controller
                                .oldPassController.text.isEmptyOrNull &&
                            controller.newPassController.text.isEmptyOrNull) {
                          await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameeController.text,
                              password: data['password']);
                          VxToast.show(context,
                              msg: "Changings saved",
                              bgColor: Colors.green,
                              textColor: Colors.white);
                        } else {
                          VxToast.show(context,
                              msg: "Your old password is incorrect",
                              bgColor: Colors.red,
                              textColor: Colors.white);
                          controller.isLoading(false);
                        }
                      },
                      child: const Text('Save'),
                    ),
            ],
          )
              .box
              .green200
              .shadow3xl
              .padding(const EdgeInsets.all(20))
              .margin(const EdgeInsets.only(
                  top: 50, left: 20, right: 20, bottom: 30))
              .rounded
              .make(),
        ),
      ),
    );
  }
}
