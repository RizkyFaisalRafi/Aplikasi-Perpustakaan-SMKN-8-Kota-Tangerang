import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../provider/auth_provider.dart';
import '../util/theme.dart';

class HeaderHomeScreen extends StatelessWidget {
  const HeaderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = AuthProvider().currentUser;
    return Container(
      color: Colors.white,
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 24, fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    // 'Rizky Faisal Rafi',
                    user?.email ?? 'User Email',
                    style: TextStyle(fontSize: 24, fontWeight: bold),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/logo_smkn_8_kotang.png',
              width: 100,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
