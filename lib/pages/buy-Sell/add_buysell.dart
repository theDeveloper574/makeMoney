import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/service/model/buy_sell_model.dart';
import 'package:makemoney/service/stateManagment/provider/buy_sell_provider.dart';
import 'package:makemoney/widgets/text_field_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../service/stateManagment/controller/profile_con.dart';
import '../../widgets/buy_sell_save_button.dart';

class AddBuySell extends StatelessWidget {
  AddBuySell({super.key});
  final desCon = TextEditingController();
  final numberCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final con = Get.put(ProfileCon());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: const Text(
          "خرید فروخت شامل کریں",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: LoaderOverlay(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text("براہ کرم تصویر درج کریں۔"),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () async {
                    Permission.storage.request();
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
                        con.pickImageCam();
                      },
                      onConfirm: () async {
                        Navigator.pop(context);
                        con.pickImageGall();
                      },
                    );
                  },
                  child: Obx(() {
                    return SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: con.imagePath.isNotEmpty
                            ? FutureBuilder<bool>(
                                future: File(con.imagePath.value).exists(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError ||
                                      !snapshot.data!) {
                                    return const Center(
                                      child: Text('Image not found.'),
                                    );
                                  } else {
                                    return Image.file(
                                      File(con.imagePa!.path),
                                      fit: BoxFit.cover,
                                    );
                                  }
                                },
                              )
                            : Image.asset(
                                'assets/logos/placeholder.jpg',
                                fit: BoxFit.cover,
                              )
                        // : const Center(
                        //     child: Text('No image selected'),
                        //   ),
                        );
                  }),
                  // child: Obx(()={}),
                ),
                const SizedBox(height: 16),
                const Text("تصویر کے بارے میں بتائیں"),
                const SizedBox(height: 6),
                TextFieldWidget(
                  left: 0,
                  right: 0,
                  top: 0,
                  controller: desCon,
                  hintText: 'تصویر کے بارے میں بتائیں',
                ),
                const SizedBox(height: 16),
                const Text("براہ کرم اپنا نمبر درج کریں۔"),
                const SizedBox(height: 6),
                TextFieldWidget(
                  left: 0,
                  right: 0,
                  top: 0,
                  keyboardType: TextInputType.number,
                  controller: numberCon,
                  maxLen: 11,
                  hintText: 'براہ کرم اپنا نمبر درج کریں۔',
                ),
                const SizedBox(height: 16),
                Center(
                  child: SaveButton(
                    onSave: () async {
                      final pro =
                          Provider.of<BuySellProvider>(context, listen: false);
                      if (con.imagePa == null) {
                        AppUtils().toast('براہ کرم تصویر درج کریں۔');
                      } else if (desCon.text.isEmpty) {
                        AppUtils().toast('تصویر کے بارے میں بتائیں');
                      } else if (numberCon.text.isEmpty) {
                        AppUtils().toast('براہ کرم اپنا نمبر درج کریں۔');
                      } else if (numberCon.text.length < 11) {
                        AppUtils().toast('براہ کرم اپنا نمبر درج کریں۔');
                      } else {
                        context.loaderOverlay.show();
                        FocusScope.of(context).unfocus();
                        AppUtils().toast('Please Wait for image verification.');
                        firebase_storage.Reference profileImgRef =
                            firebase_storage.FirebaseStorage.instance
                                .ref('makeMoneyBuySellPicture')
                                .child(AppUtils().generateFormattedString());

                        ///set profile storage
                        UploadTask uploadTask = profileImgRef.putFile(
                          File(con.imagePath.value),
                          SettableMetadata(
                            contentType: "image/jpeg",
                          ),
                        );
                        await Future.value(uploadTask);
                        var profileUrl = await profileImgRef.getDownloadURL();
                        String docId = AppUtils().generateFormattedString();
                        BuySellModel model = BuySellModel(
                          isDeleted: false,
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          docId: docId,
                          createdAt: DateTime.now(),
                          number: int.parse(numberCon.text),
                          description: desCon.text,
                          image: profileUrl,
                        );
                        await pro.addBuySell(model);
                        context.loaderOverlay.hide();
                        Get.back();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
