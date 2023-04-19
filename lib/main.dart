import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/about_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/call_dev_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/home_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/login_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/register_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      routes: {
        '/': (context) => const SplashScreenn(),
        '/login-screen': (context) => const LoginScreen(),
        '/register-screen': (context) => const RegisterScreen(),
        '/home-screen': (context) => const HomeScreen(),
        '/call-dev-screen': (context) => const CallDevScreen(),
        '/about-app-screen': (context) => const AboutScreen(),
      },
    );
  }
}
