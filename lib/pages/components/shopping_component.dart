import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/constants.dart';
import 'package:makemoney/pages/components/cloths_gallery.dart';
import 'package:makemoney/pages/components/flowers_gallery.dart';
import 'package:makemoney/widgets/boxes.dart';

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
          )
        ],
      ),
    );
  }
}
