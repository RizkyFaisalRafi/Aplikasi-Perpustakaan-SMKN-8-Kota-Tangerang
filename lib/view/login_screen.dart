import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/provider/auth_provider.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/util/theme.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/register_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/widget/auth_button_general.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/widget/custom_text_field.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/widget/header_signin_signup.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, _) {
      return Scaffold(
          body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // header(),
                  const HeaderSigninSignup(title: 'Sign In'),
                  // Email
                  CustomTextField(
                    controller: provider.controllerEmail,
                    hintText: 'Your Email Address',
                    imageAsset: 'assets/images/icon_email.png',
                    obscureText: false,
                  ),

                  // Password
                  CustomTextField(
                    controller: provider.controllerPassword,
                    hintText: 'Your Password',
                    imageAsset: 'assets/images/icon_password.png',
                    obscureText: true,
                  ),

                  const SizedBox(
                    height: 32,
                  ),

                  // Sign In Button
                  AuthButtonGeneral(
                    backgroundColor: primaryColor,
                    title: 'Sign In',
                    fontWeight: medium,
                    fontColor: whiteColor,
                    onTap: () {
                      provider.signInWithEmailAndPassword();
                    },
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  Text(
                    'OR',
                    style: TextStyle(fontWeight: semiBold, fontSize: 20),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // Sign Up Button
                  AuthButtonGeneral(
                    backgroundColor: whiteColor,
                    title: 'Sign Up',
                    fontWeight: medium,
                    fontColor: primaryColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    });
  }
}
