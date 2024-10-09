import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/constants.dart';

class ContainerWidget extends StatelessWidget {
  final String? task;
  final String? urdu;
  final Color? bgColor;
  final Color? textColor;
  final Function()? onTap;
  const ContainerWidget({
    super.key,
    this.task,
    this.urdu,
    this.bgColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.blurColor,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Text(
                task ?? "Coming soon",
                style: TextStyle(fontSize: 22, color: textColor),
              ),
              Text(
                urdu ?? "جلد آرہا ہے۔",
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: Get.height * 0.007)
            ],
          ),
        ),
      ),
    );
  }
}
