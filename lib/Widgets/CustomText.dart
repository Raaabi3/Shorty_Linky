import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign? alignment;
  final int? maxLines;
  final TextOverflow? overflow;
  double? size;

  CustomText.title({
    super.key,
    required this.text,
    this.alignment,
  }) : 
    maxLines = null,
    overflow = null,
    _style = TextStyle(
      fontSize: 30,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      letterSpacing: 1.5,
      shadows: [
        Shadow(color: Colors.black, blurRadius: 2, offset: Offset(1, 1)),
      ],
    );

  CustomText.title2 ({super.key,
    required this.text,
    this.alignment,}) : 
    maxLines = null,
    overflow = null,
    _style = TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  CustomText.subtitle({
    super.key,
    required this.text,
    this.alignment = TextAlign.center,
    this.maxLines = 2,
    this.overflow = TextOverflow.ellipsis,
    this.size = 20
  }) : 
    _style = TextStyle(
      color: Colors.grey[900],
      fontSize: size,
    );

  final TextStyle _style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment,
      maxLines: maxLines,
      overflow: overflow,
      style: _style,
    );
  }
}