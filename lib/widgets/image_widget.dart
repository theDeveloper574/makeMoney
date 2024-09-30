import 'dart:math';

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  const ImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    int photoId = Random().nextInt(30) + 55;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imagePath,
        scale: 1,
        fit: BoxFit.cover,
      ),
    );
  }
}
