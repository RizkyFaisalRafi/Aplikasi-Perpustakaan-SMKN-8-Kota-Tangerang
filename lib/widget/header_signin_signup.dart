import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../util/theme.dart';

class HeaderSigninSignup extends StatelessWidget {
  final String titleAtas;
  final String titleBawah;
  const HeaderSigninSignup({
    super.key,
    required this.titleAtas,
    required this.titleBawah,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, _) {
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
                  provider.authType == AuthType.signUp
                      ? Text(
                          titleAtas,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: bold,
                          ),
                        )
                      : Text(
                          titleBawah,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: bold,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
