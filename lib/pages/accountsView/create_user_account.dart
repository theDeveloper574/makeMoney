import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/pages/home.dart';
import 'package:makemoney/service/stateManagment/controller/profile_con.dart';
import 'package:makemoney/widgets/user_image_widget.dart';
import 'package:provider/provider.dart';

import '../../core/commen/app_utils.dart';
import '../../service/model/user_model.dart';
import '../../service/stateManagment/provider/account_provider.dart';
import '../../service/stateManagment/provider/user_provider.dart';
import '../../widgets/text_field_widget.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CrateUserAccount extends StatelessWidget {
  CrateUserAccount({super.key});
  final nameCon = TextEditingController();

  final phoneCon = TextEditingController();

  final cityCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final phonePro = Provider.of<UserAccount>(listen: false, context);
    phoneCon.text = phonePro.phoneNum ?? "";
    final con = Get.put(ProfileCon());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crate Account"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.04),
            const ProfilePageImage(),
            TextFieldWidget(
              readyOnly: true,
              keyboardType: TextInputType.number,
              controller: phoneCon,
              hintText: "نمبر درج کریں",
            ),
            TextFieldWidget(
              maxLen: 11,
              controller: nameCon,
              hintText: "اپنا نام درج کریں",
            ),
            TextFieldWidget(
              maxLen: 11,
              controller: cityCon,
              hintText: "اپنے شہر کا نام درج کریں۔",
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameCon.text.isEmpty) {
                  AppUtils().toast('براہ کرم نام نام درج کریں۔');
                } else if (cityCon.text.isEmpty) {
                  AppUtils().toast('براہ کرم شہر کا نام درج کریں۔');
                } else if (con.imagePa == null) {
                  AppUtils().toast('براہ کرم اپنی تصویر درج کریں۔');
                } else {
                  final createAcc = Provider.of<UserProvider>(
                    context,
                    listen: false,
                  );
                  AppUtils().toast('Please Wait for image verification.');
                  firebase_storage.Reference profileImgRef = firebase_storage
                      .FirebaseStorage.instance
                      .ref('makeMoneyprofileImage')
                      .child(
                        FirebaseAuth.instance.currentUser!.uid.toString(),
                      );

                  ///set profile storage
                  UploadTask uploadTask = profileImgRef.putFile(
                    File(con.imagePath.value),
                    SettableMetadata(
                      contentType: "image/jpeg",
                    ),
                  );
                  FocusScope.of(context).unfocus();
                  await Future.value(uploadTask);
                  var profileUrl = await profileImgRef.getDownloadURL();
                  String docId = AppUtils().generateFormattedString();
                  final model = UserModel(
                    createdAt: DateTime.now(),
                    docId: docId,
                    name: nameCon.text,
                    phoneNumber: phoneCon.text,
                    profileUrl: profileUrl,
                    uid: FirebaseAuth.instance.currentUser?.uid,
                    isDeleted: false,
                  );
                  await createAcc.addUser(model).then((a) {
                    AppUtils().toast('Account Successfully.');
                    Get.offAll(() => const HomePage());
                  });
                }
              },
              child: Consumer<UserProvider>(builder: (context, value, child) {
                if (value.isLoading) {
                  return AppUtils().waitLoading();
                } else {
                  return const Text("Create Account");
                }
              }),
            ),
            SizedBox(height: Get.height * 0.04),
          ],
        ),
      ),
    );
  }
}
