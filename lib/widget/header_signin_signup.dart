import 'package:flutter/material.dart';

import '../util/theme.dart';

class HeaderSigninSignup extends StatelessWidget {
  final String title;
  const HeaderSigninSignup({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 28),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo_smkn_8_kotang.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  title,
                  style: TextStyle(fontWeight: bold, fontSize: 28),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
