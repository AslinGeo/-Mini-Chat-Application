import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final Color borderColor;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 40,
    this.backgroundColor = const Color(0xff245D6B),
    this.borderColor = Colors.transparent,
    this.textColor = Colors.white,
    this.fontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
          
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}