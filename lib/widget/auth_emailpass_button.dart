import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class AuthEmailpassButton extends StatelessWidget {
  final String titleAtas;
  final String titleBawah;
  final Color backgroundColor;
  final Color fontColor;
  final FontWeight fontWeight;
  final Function()? onTap;

  const AuthEmailpassButton({
    super.key,
    required this.backgroundColor,
    required this.titleAtas,
    required this.titleBawah,
    required this.fontWeight,
    required this.fontColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, _) {
        return Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
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
            child: provider.authType == AuthType.signUp
                ? Text(
                    titleAtas,
                    style: TextStyle(
                        fontSize: 16, fontWeight: fontWeight, color: fontColor),
                  )
                : Text(
                    titleBawah,
                    style: TextStyle(
                        fontSize: 16, fontWeight: fontWeight, color: fontColor),
                  ),
          ),
        );
      },
    );
  }
}
