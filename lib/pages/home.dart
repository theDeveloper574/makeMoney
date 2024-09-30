import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/constants.dart';
import 'package:makemoney/pages/components/business_com.dart';
import 'package:makemoney/pages/components/mobile_component.dart';
import 'package:makemoney/pages/components/shopping_component.dart';
import 'package:makemoney/widgets/boxes.dart';

import 'components/quran_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.01),
            Container(
              decoration: BoxDecoration(
                color: AppColors.blurColor,
                borderRadius: BorderRadius.circular(8),
              ),
              width: double.infinity,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Future Invest",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 34.0),
                          child: Text("CEO"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "مہک شبیر",
                              style: TextStyle(fontSize: 22),
                            ),
                            SizedBox(width: 12),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
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
                    Get.to(() => VideoPlayerCom());
                  },
                ),
                Boxes(
                  text1: "موبائل ایپ بنائیں",
                  bgColor: Colors.green,
                  text2: "Mobile App",
                  image: LocalImg.app,
                  onTap: () {
                    Get.to(() => MobileComponent());
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
                      "Coming soon",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      "جلد آرہا ہے۔",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
