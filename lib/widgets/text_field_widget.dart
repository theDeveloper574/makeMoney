import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final bool? readyOnly;
  final int? maxLen;
  final String? labelText;
  final String? hintText;
  final bool? isShow;
  final Widget? suffixWidget;
  final Widget? prefixIcon;
  final double? left;
  final double? right;
  final double? top;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.keyboardType,
    this.inputAction,
    this.maxLen,
    this.hintText,
    this.readyOnly,
    this.labelText,
    this.isShow,
    this.suffixWidget,
    this.prefixIcon,
    this.left,
    this.right,
    this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left ?? 15.0,
        right: right ?? 15.0,
        top: top ?? 15,
        bottom: 0,
      ),
      child: TextFormField(
        readOnly: readyOnly ?? false,
        obscureText: isShow ?? false,
        controller: controller,
        textInputAction: inputAction,
        keyboardType: keyboardType,
        maxLength: maxLen,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixWidget,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
