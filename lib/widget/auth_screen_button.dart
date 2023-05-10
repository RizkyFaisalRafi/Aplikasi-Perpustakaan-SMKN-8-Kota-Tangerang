import 'package:flutter/material.dart';

class AuthScreenButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function()? onTap;
  const AuthScreenButton(
      {super.key, required this.iconData, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData),
              const SizedBox(
                width: 8,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
