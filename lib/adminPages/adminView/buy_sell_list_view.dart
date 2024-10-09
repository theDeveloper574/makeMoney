import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/service/stateManagment/provider/buy_sell_provider.dart';
import 'package:makemoney/widgets/listtile_shimmer_widget.dart';
import 'package:provider/provider.dart';

import '../../core/commen/constants.dart';
import '../../service/model/buy_sell_model.dart';
import '../../widgets/image_view.dart';

class BuySellListView extends StatelessWidget {
  const BuySellListView({super.key});

  @override
  Widget build(BuildContext context) {
    final buySellProvider =
        Provider.of<BuySellProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy Sell Admin"),
      ),
      body: StreamBuilder<List<BuySellModel>>(
        stream: buySellProvider.gteStreAdmin(), // Connect the stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ListTileShimmerWidget();
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
            return ListView.builder(
              itemCount: buySellList.length,
              itemBuilder: (context, index) {
                final item = buySellList[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  color: item.isDeleted!
                      ? Colors.redAccent.withOpacity(0.3)
                      : Colors.green.withOpacity(0.3),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(4.0),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[200], // Background color
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => ImageViewWidget(image: item.image!),
                          );
                        },
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: item.image!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      item.description!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // Increased font size
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.number.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          DateFormatter.formatDate(item.createdAt!),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () async {
                        if (item.isDeleted!) {
                          AppUtils().customDialog(
                            context: context,
                            onDone: () async {
                              bool setDelete = item.isDeleted = false;
                              buySellProvider.updateforAdmin(item, setDelete);
                              AppUtils().toast('Item Un-Deleted');
                              Get.back();
                            },
                            title: "Un-Delete Item",
                            des: "un-delete this item",
                            onDoneTxt: "Ok",
                          );
                        } else {
                          AppUtils().customDialog(
                            context: context,
                            onDone: () async {
                              bool setDelete = item.isDeleted = true;
                              buySellProvider.updateforAdmin(item, setDelete);
                              AppUtils().toast('Item Deleted');
                              Get.back();
                            },
                            title: "Delete Item.",
                            des: "delete this item.",
                            onDoneTxt: "Ok",
                          );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ), // Trailing icon,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
