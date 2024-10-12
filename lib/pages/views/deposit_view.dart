import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/pages/components/deposit_view.dart';
import 'package:makemoney/service/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../core/commen/app_utils.dart';
import '../../service/stateManagment/provider/deposit_provider.dart';
import '../components/deposit_video.dart';

class DepositView extends StatefulWidget {
  final UserModel? userModel;
  const DepositView({super.key, this.userModel});
  @override
  State<DepositView> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/vidoe/jazz-cash.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deposit"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  final depositPro =
                      Provider.of<DepositProvider>(context, listen: false);
                  // Call this to fetch the latest deposits
                  await depositPro.fetchDeposits();
                  final lastDeposit = await depositPro
                      .getLastApprovedUserDeposit(widget.userModel!.uid!);
                  if (lastDeposit != null) {
                    if (lastDeposit.isApproved == true) {
                      // Navigate to the DepositMoneyCom screen
                      Get.to(
                        () => DepositMoneyCom(userModel: widget.userModel),
                      );
                    } else {
                      // Show toast if the last deposit is not approved
                      AppUtils().toast(
                          "Please wait for your last deposit to be approved.\nبراہ کرم اپنے آخری ڈپازٹ کے منظور ہونے کا انتظار کریں۔");
                    }
                  } else {
                    Get.to(
                      () => DepositMoneyCom(
                        userModel: widget.userModel,
                      ),
                    );
                  }
                },
                child: const Card(
                  color: Colors.green,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          "Deposit Money",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "رقم جمع کرو",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Get.to(() => const DepositVideo());
                },
                child: const Card(
                  color: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Watch Video Tutorial",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "ویڈیو ٹیوٹوریل دیکھیں",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
