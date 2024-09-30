import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../../service/stateManagment/provider/account_provider.dart';

class PhoneAuthView extends StatefulWidget {
  const PhoneAuthView({super.key});

  @override
  State<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  final phoneCon = TextEditingController();
  final otpVerify = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Authentication"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("اپنا فون نمبر درج کریں۔"),
            ),
            TextFieldWidget(
              keyboardType: TextInputType.number,
              maxLen: 11,
              controller: phoneCon,
              hintText: "نمبر درج کریں",
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 12, top: 12),
                child: Text(
                  "+92  ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              suffixWidget:
                  Consumer<UserAccount>(builder: (context, value, child) {
                return GestureDetector(
                  onTap: () async {
                    if (phoneCon.text.isEmpty) {
                      AppUtils().toast('اپنا فون نمبر درج کریں۔');
                    } else if (phoneCon.text.length < 11) {
                      AppUtils().toast('فون نمبر 11 الفاظ سے کم نہیں ہو سکتا');
                    } else {
                      if (value.isVerifyingPhone) {
                        AppUtils().toast("OTP already send to you number");
                      } else {
                        await value.phoneAuth(
                          phoneNumber: "+92 ${phoneCon.text}",
                        );
                      }
                    }
                  },
                  child: value.isPhoneAuth
                      ? AppUtils.loadingWid()
                      : const Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                );
              }),
            ),
            Consumer<UserAccount>(builder: (context, value, child) {
              if (value.isVerifyingPhone) {
                return TextFieldWidget(
                  keyboardType: TextInputType.number,
                  controller: otpVerify,
                  maxLen: 6,
                  suffixWidget:
                      Consumer<UserAccount>(builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () async {
                        await value.verifyPhoneNumber(
                          verificationId: value.verId.toString(),
                          smsCode: otpVerify.text,
                        );
                      },
                      child: value.isVerifyingOpt
                          ? AppUtils.loadingWid()
                          : const Icon(
                              Icons.verified,
                              color: Colors.blue,
                            ),
                    );
                  }),
                );
              } else {
                return const SizedBox();
              }
            }),
          ],
        ),
      ),
    );
  }
}
