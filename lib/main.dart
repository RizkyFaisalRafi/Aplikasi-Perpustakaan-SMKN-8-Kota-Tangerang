import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/provider/auth_provider.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/util/theme.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/util/key.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/auth_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/home_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Keys.scaffoldMessengerKey,
        theme: ThemeData(
          primaryColor: primaryColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshoot) {
            if (snapshoot.hasData) {
              return const HomeScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
      ),
    );
  }
}
