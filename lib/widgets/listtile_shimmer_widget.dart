import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListTileShimmerWidget extends StatelessWidget {
  const ListTileShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Number of shimmer items to display
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.white,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            leading: Container(
              width: 50,
              height: 50,
              color: Colors.grey,
            ),
            title: Container(
              height: 20,
              color: Colors.grey,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 15,
                  color: Colors.grey,
                ),
                const SizedBox(height: 4),
                Container(
                  height: 15,
                  width: 100,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
