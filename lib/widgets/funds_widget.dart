import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:makemoney/service/model/market_model.dart';

class FundsWidget extends StatelessWidget {
  final CryptoCurrencyModel? model;
  const FundsWidget({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      shadowColor: Colors.grey.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // <-- Radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(width: Get.width * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: CircleAvatar(
                    child: CachedNetworkImage(
                      // height: 30,
                      imageUrl: model!.image.toString(),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    // child: Image.network(model!.image.toString()),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model!.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(model!.symbol.toString()),
                  ],
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.007),
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.03),
              child: Text(
                "\$${model!.currentPrice}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.02),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "\$${model!.low24}",
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
