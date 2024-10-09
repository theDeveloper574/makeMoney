import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:provider/provider.dart';

import '../../core/commen/constants.dart';
import '../../service/model/buy_sell_model.dart';
import '../../service/stateManagment/provider/buy_sell_provider.dart';
import '../../widgets/image_view.dart';
import '../../widgets/shimmer_effect_widget.dart';
import 'add_buysell.dart';

class BuySellScreen extends StatelessWidget {
  const BuySellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buySellProvider = Provider.of<BuySellProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purpleAccent,
        title: const Text(
          'Buy Sell',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<List<BuySellModel>>(
        stream: buySellProvider.gteStre(), // Connect the stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerGridEffectWidget();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'), // Show error message
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No products found'), // No products available
            );
          } else {
            final buySellList = snapshot.data!; // Access the product list
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 0.75,
              ),
              itemCount: buySellList.length,
              itemBuilder: (context, index) {
                final buySellItem = buySellList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Card(
                    shadowColor: Colors.white,
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => ImageViewWidget(
                                    image: buySellItem.image!,
                                  ),
                                );
                              },
                              child: Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: buySellItem.image!,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            buySellItem.description!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            buySellItem.number.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormatter.formatDate(buySellItem.createdAt!),
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        shape: const CircleBorder(),
        onPressed: () async {
          final auth = FirebaseAuth.instance;
          if (auth.currentUser != null) {
            Get.to(() => AddBuySell());
          } else {
            AppUtils().snackBarUtil(
              "برائے مہربانی فروخت خریدنے سے پہلے اکاؤنٹ بنائیں",
            );
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}
