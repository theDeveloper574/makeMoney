import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/constants.dart';
import 'package:makemoney/pages/components/cloths_gallery.dart';
import 'package:makemoney/pages/components/flowers_gallery.dart';
import 'package:makemoney/widgets/boxes.dart';

import '../buy-Sell/buysell_view.dart';

class ShoppingComponent extends StatefulWidget {
  const ShoppingComponent({super.key});

  @override
  State<ShoppingComponent> createState() => _ShoppingComponentState();
}

class _ShoppingComponentState extends State<ShoppingComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Boxes(
                  text1: "کپڑے",
                  bgColor: Colors.red,
                  text2: "cloth & garments",
                  image: LocalImg.ar,
                  isShowFill: true,
                  onTap: () {
                    Get.to(() => const ClothGalleryCom());
                  },
                ),
                SizedBox(width: Get.width * 0.06),
                Boxes(
                  isShowFill: true,
                  text1: "پھول",
                  bgColor: Colors.red,
                  text2: "Flowers",
                  image: LocalImg.flowerLogo,
                  onTap: () {
                    Get.to(() => const FlowersGalleryCom());
                  },
                ),
              ],
            ),
          ),
          const Text(
            "خرید فروخت",
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              Get.to(() => BuySellScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/logos/buy-sell-img.jpg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
