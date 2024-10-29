import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:makemoney/service/stateManagment/controller/profile_con.dart';
import 'package:makemoney/widgets/user_image_widget.dart';
import 'package:provider/provider.dart';

import '../../core/commen/app_utils.dart';
import '../../service/model/user_model.dart';
import '../../service/stateManagment/provider/cu_user_provider.dart';
import '../../widgets/text_field_widget.dart';
import '../home.dart';

class GoogleAccountUser extends StatefulWidget {
  const GoogleAccountUser({super.key});

  @override
  _GoogleAccountUserState createState() => _GoogleAccountUserState();
}

class _GoogleAccountUserState extends State<GoogleAccountUser> {
  bool isLogin = false; // Track the current mode
  //
  final nameCon = TextEditingController();

  final cityCon = TextEditingController();

  final passCon = TextEditingController();

  final emailCon = TextEditingController();

  final accountCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final con = Get.put(ProfileCon());
    return Scaffold(
      appBar: buildAppBar(),
      body: LoaderOverlay(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.04),
              if (!isLogin) const ProfilePageImage(),
              Column(
                children: [
                  Form(
                    child: TextFieldWidget(
                      validator: (val) => val!.isEmpty || !val.contains("@")
                          ? "enter a valid email"
                          : null,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailCon,
                      hintText: "اپنا ای میل درج کریں",
                      autoFills: const [AutofillHints.email],
                    ),
                  ),
                  // Password Field for Both Login and Sign Up
                  TextFieldWidget(
                    controller: passCon,
                    hintText: "اپنا پاس ورڈ درج کریں۔",
                    maxLen: 8,
                  ),
                  // Show additional fields only for account creation
                  if (!isLogin) ...[
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
                    const Text(
                        "jazzcash/easypaisa  براہ کرم اپنا اکاؤنٹ نمبر درج کریں۔"),
                    const Text(
                        "یہ اکاؤنٹ نمبر تبدیل نہیں کیا جا سکتا، براہ کرم اسے دو بار چیک کریں۔"),
                    TextFieldWidget(
                      maxLen: 11,
                      controller: accountCon,
                      keyboardType: TextInputType.number,
                      hintText: "جاز کیش / ایزی پیسہ نمبر۔",
                    ),
                  ],
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  final createAcc =
                      Provider.of<CuUserProvider>(context, listen: false);

                  if (isLogin) {
                    if (emailCon.text.isEmpty) {
                      AppUtils().toast('براہ کرم اپنا ای میل درج کریں۔');
                    } else if (passCon.text.length < 7) {
                      AppUtils().toast('پاس ورڈ 7 wrods سے کم نہیں ہو سکتا');
                    } else {
                      await createAcc.signInWithEmail(
                        emailCon.text,
                        passCon.text,
                        context,
                      );
                    }
                  } else {
                    if (nameCon.text.isEmpty) {
                      AppUtils().toast('براہ کرم نام نام درج کریں۔');
                    } else if (emailCon.text.isEmpty) {
                      AppUtils().toast('براہ کرم اپنا ای میل درج کریں۔');
                    } else if (passCon.text.isEmpty) {
                      AppUtils().toast('اپنا پاس ورڈ درج کریں');
                    } else if (passCon.text.length < 7) {
                      AppUtils().toast('پاس ورڈ 7 wrods سے کم نہیں ہو سکتا');
                    } else if (cityCon.text.isEmpty) {
                      AppUtils().toast('براہ کرم شہر کا نام درج کریں۔');
                    } else if (con.imagePath.isEmpty) {
                      AppUtils().toast('براہ کرم اپنی تصویر درج کریں۔');
                    } else if (accountCon.text.isEmpty) {
                      AppUtils().toast('جاز کیش / ایزی پیسہ نمبر درج کریں۔');
                    } else if (accountCon.text.length < 11) {
                      AppUtils().toast('مکمل نمبر درج کریں۔');
                    } else {
                      context.loaderOverlay.show();
                      FocusScope.of(context).unfocus();
                      final signInMethods = await FirebaseAuth.instance
                          .fetchSignInMethodsForEmail(emailCon.text);
                      if (signInMethods.isNotEmpty) {
                        AppUtils().toast(
                            'یہ ای میل پہلے سے موجود ہے۔ براہ کرم ایک مختلف ای میل درج کریں۔');
                        context.loaderOverlay.hide();
                        return;
                      }
                      await createAcc.signUpWithEmail(
                        emailCon.text,
                        passCon.text,
                      );
                      AppUtils().toast('Please Wait for image verification.');
                      // Upload the profile image to Firebase Storage
                      firebase_storage.Reference profileImgRef =
                          firebase_storage.FirebaseStorage.instance
                              .ref('makeMoneyprofileImage')
                              .child(FirebaseAuth.instance.currentUser!.uid
                                  .toString());

                      /// Set profile storage
                      UploadTask uploadTask = profileImgRef.putFile(
                        File(con.imagePath.value),
                        SettableMetadata(
                          contentType: "image/jpeg",
                        ),
                      );

                      // Wait for the upload to complete
                      await uploadTask.whenComplete(() async {
                        var profileUrl = await profileImgRef.getDownloadURL();
                        // Call the sign-up method using email and password

                        // After signing up, create the user model and add to Firestore
                        String docId = AppUtils().generateFormattedString();
                        final model = UserModel(
                          createdAt: DateTime.now(),
                          docId: docId,
                          name: nameCon.text,
                          phoneNumber: null,
                          profileUrl: profileUrl,
                          uid: FirebaseAuth.instance.currentUser?.uid,
                          isDeleted: false,
                          paymentStatus: false,
                          balance: 0,
                          email: emailCon.text,
                          coinBalance: 0,
                          password: passCon.text,
                          accountNumber: accountCon.text,
                        );

                        await createAcc.addUser(model).then((a) {
                          context.loaderOverlay.hide();
                          AppUtils().toast('Account Successfully created.');
                          Get.offAll(() => const HomePage());
                        });
                      }).catchError((error) {
                        context.loaderOverlay.hide();
                        AppUtils().toast('Error uploading image: $error');
                      });
                    }
                  }
                },
                child:
                    Consumer<CuUserProvider>(builder: (context, value, child) {
                  if (value.isLoading) {
                    return AppUtils().waitLoading();
                  } else {
                    return Text(isLogin ? "Log In" : "Create Account",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16));
                  }
                }),
              ),
              SizedBox(height: Get.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar with Log In Button
  AppBar buildAppBar() {
    return AppBar(
      title:
          const Text("Create Google Account", style: TextStyle(fontSize: 16)),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: Size(isLogin ? 140 : 90, 30),
            padding: const EdgeInsets.all(2),
          ),
          onPressed: () {
            setState(() {
              isLogin = !isLogin; // Toggle between login and create account
            });
          },
          child: Consumer<CuUserProvider>(builder: (context, value, child) {
            if (value.isLoading) {
              return AppUtils().waitLoading();
            } else {
              return Text(isLogin ? "Switch to Sign Up" : "Log In",
                  style: const TextStyle(color: Colors.white, fontSize: 14));
            }
          }),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
