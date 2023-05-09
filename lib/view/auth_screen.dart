import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/provider/auth_provider.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/email_pass_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/home_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/widget/auth_button.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Select Auth Provider',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    AuthButton(
                      iconData: Icons.email,
                      title: 'Email/Password',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmailPassScreen(),
                          ),
                        );
                      },
                    ),
                    Consumer<AuthProvider>(builder: (context, provider, _) {
                      return AuthButton(
                        iconData: FontAwesomeIcons.google,
                        title: 'Google',
                        onTap: () {
                          provider.signInWithGoogle();
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
