import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomText(
      {super.key,
      required this.text,
      this.size,
      this.color,
      this.weight,
      this.textAlign,
      this.overflow,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          fontSize: size ?? 16,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
