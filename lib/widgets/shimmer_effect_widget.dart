import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectWidget extends StatelessWidget {
  const ShimmerEffectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 12, // You can show as many shimmer items as you like
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: Get.width / 3, // Width of the shimmer widget
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerGridEffectWidget extends StatelessWidget {
  const ShimmerGridEffectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 0, // Horizontal space between grid items
        mainAxisSpacing: 0, // Vertical space between grid items
        childAspectRatio: 0.75, // Adjust the ratio based on item size
      ),
      itemCount: 6, // Number of shimmer items you want to display
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              // margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey[300], // Shimmer effect for image
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    color: Colors.grey[300], // Shimmer effect for title
                    height: 15,
                    width: 100,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    color: Colors.grey[300], // Shimmer effect for description
                    height: 12,
                    width: 150,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
