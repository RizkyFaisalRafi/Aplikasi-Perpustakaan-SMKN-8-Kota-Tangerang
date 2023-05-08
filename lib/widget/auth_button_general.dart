import 'package:flutter/material.dart';

class AuthButtonGeneral extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color fontColor;
  final FontWeight fontWeight;
  final Function()? onTap;

  const AuthButtonGeneral({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.fontWeight,
    required this.fontColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 0),
        ),
      ]),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: Text(
          title,
          style:
              TextStyle(fontSize: 16, fontWeight: fontWeight, color: fontColor),
        ),
      ),
    );
  }
}
