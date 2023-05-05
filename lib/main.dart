import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/auth.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/about_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/call_dev_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/home_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/login_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/register_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/wrapper.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: true,
    //   routes: {
    //     '/': (context) => const Wrapper(),
    //     '/login-screen': (context) => const LoginScreen(),
    //     '/register-screen': (context) => const RegisterScreen(),
    //     '/home-screen': (context) => const HomeScreen(),
    //     '/call-dev-screen': (context) => const CallDevScreen(),
    //     '/about-app-screen': (context) => const AboutScreen(),
    //   },
    // );

    // Firebase Authentication anonymous, email and password
    return StreamProvider.value(
      value: Auth.firebaseUserStream,
      initialData: null,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
