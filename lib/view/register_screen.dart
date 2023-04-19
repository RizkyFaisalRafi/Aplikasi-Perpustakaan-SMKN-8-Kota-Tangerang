import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/theme.dart';

const List<String> listGender = <String>['Pria', 'Wanita'];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    /// Header
    Widget header() {
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
                  Text(
                    'Register',
                    style: TextStyle(fontWeight: bold, fontSize: 28),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    /// Form Name
    Widget nameInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: const Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_name.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Your Name',
                            hintStyle: TextStyle(
                              color: Color(0xff949494),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    /// Form Gender
    Widget genderInput() {
      String dropdownValue = listGender.first;
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: const Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_gender.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.arrow_right,
                      ),
                      elevation: 16,
                      style: const TextStyle(color: Color(0xff949494)),
                      underline: Container(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: listGender
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )

                        // TextFormField(
                        //   style: const TextStyle(color: Colors.black),
                        //   obscureText: true,
                        //   decoration: const InputDecoration.collapsed(
                        //     hintText: 'Your Gender',
                        //     hintStyle: TextStyle(
                        //       color: Color(0xff949494),
                        //     ),
                        //   ),
                        // ),

                        ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    /// Form Email
    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: const Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_email.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Your Email Address',
                            hintStyle: TextStyle(
                              color: Color(0xff949494),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    /// Form Password
    Widget passInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: const Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_password.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Your Password',
                          hintStyle: TextStyle(
                            color: Color(0xff949494),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    /// Sign Up Button
    Widget signUpButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 60, bottom: 16),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login-screen');
          },
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            'Sign Up',
            style: TextStyle(
                fontSize: 16, fontWeight: medium, color: Colors.white),
          ),
        ),
      );
    }

    /// Sign In Button
    Widget signInButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 16, bottom: 12),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ]),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login-screen');
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            'Sign In',
            style: TextStyle(
                fontSize: 16, fontWeight: medium, color: primaryColor),
          ),
        ),
      );
    }

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            children: [
              header(),
              nameInput(),
              genderInput(),
              emailInput(),
              passInput(),
              signUpButton(),
              Text(
                'OR',
                style: TextStyle(fontWeight: semiBold, fontSize: 20),
              ),
              signInButton(),
            ],
          ),
        ),
      ),
    ));
  }
}
