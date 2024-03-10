import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? weight;

  const CustomText(
      {super.key,
      required this.text,
      this.size,
      this.color,
      this.weight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: size ?? 16,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
