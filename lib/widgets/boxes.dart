import 'package:flutter/material.dart';
import 'package:makemoney/core/commen/constants.dart';

class Boxes extends StatelessWidget {
  final String? text1;
  final String text2;
  final Color? bgColor;
  final String? image;
  final bool isShowFill;
  final void Function()? onTap;
  const Boxes({
    super.key,
    this.text1,
    required this.text2,
    this.bgColor,
    this.image,
    this.isShowFill = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text1 ?? "",
            textAlign: TextAlign.center,
          ),
          Container(
            padding:
                isShowFill ? const EdgeInsets.all(0) : const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: bgColor,
            ),
            child: Image.asset(
              image ?? LocalImg.logo,
              height: isShowFill ? 120 : 50,
              width: isShowFill ? 120 : 50,
              fit: isShowFill ? BoxFit.fill : BoxFit.contain,
            ),
          ),
          Text(
            text2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
