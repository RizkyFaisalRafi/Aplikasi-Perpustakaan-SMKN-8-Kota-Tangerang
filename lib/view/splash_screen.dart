import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreenn extends StatefulWidget {
  const SplashScreenn({Key? key}) : super(key: key);

  @override
  State<SplashScreenn> createState() => _SplashScreennState();
}

class _SplashScreennState extends State<SplashScreenn> {
  @override
  void initState() {

    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushNamed(context, '/login-screen'),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 170,
          height: 170,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/logo_smkn_8_kotang.png'))),
        ),
      ),
    );
  }
}
