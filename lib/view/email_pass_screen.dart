import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/home_screen.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../util/theme.dart';
import '../widget/auth_emailpass_button.dart';
import '../widget/custom_text_field.dart';
import '../widget/header_signin_signup.dart';

import 'package:flutter/material.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

void main() => runApp(const DropdownButtonApp());

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownButton Sample')),
        body: const Center(
          child: DropdownButtonExample(),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class EmailPassScreen extends StatefulWidget {
  const EmailPassScreen({super.key});

  @override
  State<EmailPassScreen> createState() => _EmailPassScreenState();
}

class _EmailPassScreenState extends State<EmailPassScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, _) {
      // String dropdownValue = list.first;

      return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
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
                            const HeaderSigninSignup(
                              titleAtas: 'Sign Up',
                              titleBawah: 'Sign In',
                            ),

                            if (provider.authType == AuthType.signUp)
                              // Name
                              CustomTextField(
                                controller: provider.controllerName,
                                hintText: 'Your Name',
                                imageAsset: 'assets/images/icon_name.png',
                                obscureText: false,
                              ),

                            // DropdownButton<String>(
                            //   value: dropdownValue,
                            //   icon: const Icon(Icons.arrow_downward),
                            //   elevation: 16,
                            //   style: const TextStyle(color: Colors.deepPurple),
                            //   underline: Container(
                            //     height: 2,
                            //     color: Colors.deepPurpleAccent,
                            //   ),
                            //   onChanged: (String? value) {
                            //     // This is called when the user selects an item.
                            //     setState(() {
                            //       dropdownValue = value!;
                            //     });
                            //   },
                            //   items: list.map<DropdownMenuItem<String>>(
                            //       (String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(value),
                            //     );
                            //   }).toList(),
                            // ),

                            // genderInput(),

                            // Email
                            CustomTextField(
                                controller: provider.controllerEmail,
                                hintText: 'Your Email Address',
                                imageAsset: 'assets/images/icon_email.png',
                                obscureText: false),

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

                            AuthEmailpassButton(
                              backgroundColor: primaryColor,
                              titleAtas: 'Sign Up',
                              titleBawah: 'Sign In',
                              fontWeight: medium,
                              fontColor: whiteColor,
                              onTap: () {
                                provider.authenticate();
                              },
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            Text(
                              'OR',
                              style:
                                  TextStyle(fontWeight: semiBold, fontSize: 20),
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            AuthEmailpassButton(
                              backgroundColor: whiteColor,
                              titleAtas: 'Sign In',
                              titleBawah: 'Sign Up',
                              fontWeight: medium,
                              fontColor: primaryColor,
                              onTap: () {
                                provider.setAuthType();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) => const LoginScreen(),
                                //   ),
                                // );
                              },
                            ),

                            if (provider.authType == AuthType.signIn)
                              Container(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    provider.resetPassword(context);
                                  },
                                  child: const Text('Lupa Password',
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const HomeScreen();
            }
          });
    });
  }
}
