import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/service/model/user_model.dart';
import 'package:makemoney/widgets/buy_sell_save_button.dart';
import 'package:makemoney/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/model/deposit_model.dart';
import '../../service/stateManagment/provider/deposit_provider.dart';

class DepositMoneyCom extends StatefulWidget {
  final UserModel? userModel;
  const DepositMoneyCom({super.key, this.userModel});

  @override
  State<DepositMoneyCom> createState() => _DepositMoneyComState();
}

class _DepositMoneyComState extends State<DepositMoneyCom> {
  final amountCon = TextEditingController();
  bool isCompleted = false;
  int? depositAmount; // Deposit amount as integer

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("رقم جمع کرو"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isCompleted)
                SizedBox(
                  child: Column(
                    children: [
                      const Text(
                        "برائے مہربانی موبائل اکاؤنٹ کھولیں اور اس نمبر پر رقم بھیجیں۔",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "رقم:  $depositAmount",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Jazz Cash Acc Name:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                      const Text(
                        "Nelam Shabir",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "0308 2347242",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                const ClipboardData(text: '03082347242'),
                              );
                              AppUtils().toast('نمبر کاپی ہو گیا ہے');
                            },
                            child: const Icon(
                              Icons.copy,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "واٹس ایپ پر رقم کا اسکرین شاٹ بھیجیں",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: openWhatsApp,
                        child: const Text(
                          "اسکرین شاٹ بھیجیں",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    TextFieldWidget(
                      maxLen: 11,
                      keyboardType: TextInputType.number,
                      controller: amountCon,
                      hintText: 'براہ کرم رقم درج کریں۔',
                    ),
                    const SizedBox(height: 40),
                    SaveButton(
                      onSave: () async {
                        if (amountCon.text.isEmpty) {
                          AppUtils().toast('براہ کرم رقم درج کریں');
                        } else {
                          // Parse the text as a double for validation
                          double? amount;
                          try {
                            amount = double.parse(amountCon.text);
                          } catch (e) {
                            AppUtils().toast('براہ کرم درست رقم درج کریں');
                            return;
                          }

                          // Validate if the amount is less than 1200
                          if (amount < 1200) {
                            AppUtils().toast('رقم 1200 سے کم نہیں ہو سکتی');
                          } else {
                            // Store depositAmount as int
                            depositAmount = amount.toInt();
                            context.loaderOverlay.show();
                            String docId = AppUtils().generateFormattedString();
                            final depositPro = Provider.of<DepositProvider>(
                              context,
                              listen: false,
                            );
                            DepositModel model = DepositModel(
                              isApproved: false,
                              name: widget.userModel!.name,
                              jazzCashNumber: widget.userModel!.accountNumber,
                              depositAmount:
                                  depositAmount, // Use the parsed int value
                              createdAt: DateTime.now(),
                              number: widget.userModel!.phoneNumber,
                              uid: widget.userModel!.uid,
                              docId: docId,
                            );

                            await depositPro.addDeposit(model);
                            context.loaderOverlay.hide();
                            setState(() {
                              isCompleted = true;
                            });
                          }
                        }
                      },
                      text: 'جمع کریں',
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  final String phoneNumber = "923091429758";

  Future<void> openWhatsApp() async {
    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'WhatsApp نہیں کھل سکا';
    }
  }
}
