import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/constants.dart';
import 'package:makemoney/pages/components/business_com.dart';
import 'package:makemoney/pages/components/mobile_component.dart';
import 'package:makemoney/pages/components/shopping_component.dart';
import 'package:makemoney/widgets/boxes.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../adminPages/admin_view.dart';
import '../service/stateManagment/provider/cu_user_provider.dart';
import '../service/stateManagment/provider/fetch_task_provider.dart';
import '../widgets/binance_ad_widget.dart';
import 'components/quran_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    final userPro = Provider.of<CuUserProvider>(context, listen: false);
    final taskPro = Provider.of<TaskProvider>(context, listen: false);
    _controller = VideoPlayerController.asset('assets/vidoe/home-vidoe.mp4');
    _controller.addListener(() {
      setState(() {});
    });

    User? cuUid = FirebaseAuth.instance.currentUser;
    if (cuUid != null) {
      userPro.loadUser(cuUid.uid);
      taskPro.getSocialLinks();
    }
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
        backgroundColor: Colors.green,
        actions: [
          // cuProvider.user?.uid == "W59hbs0PkFc8V9zbKrq62JEU4uO2"
          //     ? InkWell(
          //         onTap: () {
          //           Get.to(() => const AdminView());
          //         },
          //         child: const Padding(
          //           padding: EdgeInsets.symmetric(horizontal: 22.0),
          //           child: Icon(
          //             Icons.admin_panel_settings,
          //             size: 30,
          //             color: Colors.white,
          //           ),
          //         ),
          //       )
          //     : const SizedBox(),
          Consumer<CuUserProvider>(builder: (context, value, child) {
            if (value.user != null) {
              if (value.user!.uid == 'W59hbs0PkFc8V9zbKrq62JEU4uO2') {
                return InkWell(
                  onTap: () {
                    Get.to(() => const AdminView());
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.0),
                    child: Icon(
                      Icons.admin_panel_settings,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints.expand(height: 110.0),
                child: Image.asset(
                  AssetsImg.bismillah,
                ),
              ),
              // SizedBox(height: Get.height * 0.01),
              // Container(
              //   decoration: BoxDecoration(
              //     color: AppColors.blurColor,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   width: double.infinity,
              //   child: const Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           "Future Invest",
              //           style: TextStyle(
              //             fontSize: 24,
              //           ),
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: [
              //             Padding(
              //               padding: EdgeInsets.only(right: 34.0),
              //               child: Text("CEO"),
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               children: [
              //                 Text(
              //                   "Mahak Shabir",
              //                   style: TextStyle(fontSize: 22),
              //                 ),
              //                 SizedBox(width: 12),
              //               ],
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/home-image.png'),
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Boxes(
                    text1: "قرآن پاک",
                    bgColor: Colors.red,
                    text2: "Holy Quran",
                    image: LocalImg.quran,
                    onTap: () {
                      Get.to(() => const VideoPlayerCom());
                    },
                  ),
                  Boxes(
                    text1: "موبائل ایپ بنائیں",
                    bgColor: Colors.green,
                    text2: "Mobile App",
                    image: LocalImg.app,
                    onTap: () {
                      Get.to(() => const MobileComponent());
                    },
                  ),
                  Boxes(
                    text1: "کاروبار",
                    bgColor: Colors.yellow,
                    text2: "Business",
                    image: LocalImg.business,
                    onTap: () {
                      Get.to(() => const BusinessCom());
                    },
                  ),
                  Boxes(
                    text1: "خریداری",
                    bgColor: Colors.blue,
                    text2: "Shopping",
                    image: LocalImg.shop,
                    onTap: () {
                      Get.to(() => const ShoppingComponent());
                    },
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              const BinanceAdWidget(),
              SizedBox(height: Get.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.green),
                        height: Get.height / 3.8,
                        child: _controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: Get.width /
                          2.8, // You can adjust this to position the button
                      child: GestureDetector(
                        onTap: () {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        },
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.stop
                              : Icons.play_arrow,
                          size: 50, // Increased size for better visibility
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.blurColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                child: const Center(
                  child: Column(
                    children: [
                      Text(
                        "add",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
