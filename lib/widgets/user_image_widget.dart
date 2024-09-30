import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/constants.dart';
import 'package:makemoney/service/stateManagment/controller/profile_con.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePageImage extends StatefulWidget {
  const ProfilePageImage({Key? key}) : super(key: key);

  @override
  State<ProfilePageImage> createState() => _ProfilePageImageState();
}

class _ProfilePageImageState extends State<ProfilePageImage> {
  final con = Get.put(ProfileCon());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.blurColor,
              radius: MediaQuery.sizeOf(context).height * 0.07,
              backgroundImage: con.imagePath.isNotEmpty
                  ? FileImage(
                      File(con.imagePath.value),
                    )
                  : null,
            ),
          );
        }),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            onPressed: () async {
              await [
                Permission.photos,
                Permission.storage,
              ].request();
              Get.defaultDialog(
                backgroundColor: Colors.white,
                buttonColor: Colors.white,
                title: 'Get Image From',
                middleText: 'Camera OR Gallery',
                textConfirm: 'Gallery',
                confirmTextColor: Colors.black,
                textCancel: 'Camera',
                cancelTextColor: Colors.black,
                onCancel: () {
                  Navigator.pop(context);
                  con.pickImageCam();
                },
                onConfirm: () async {
                  Navigator.pop(context);
                  con.pickImageGall();
                },
              );
            },
            icon: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}
