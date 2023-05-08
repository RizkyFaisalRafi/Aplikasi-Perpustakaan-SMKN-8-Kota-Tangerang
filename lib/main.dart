import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/auth.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/theme.dart';
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
    // Firebase Authentication email and password
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: StreamProvider.value(
        value: Auth.firebaseUserStream,
        initialData: null,
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      ),
    );
  }
}
