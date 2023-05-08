import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/util/theme.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/login_screen.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../widget/auth_button_general.dart';
import '../widget/custom_text_field.dart';
import '../widget/header_signin_signup.dart';

const List<String> listGender = <String>['Pria', 'Wanita'];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? errorMessage = '';
  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('user');
  }

  // RealTime Database
  // upload() async {
  //   try {
  //     Map<String, String> user = {
  //       'name': _controllerName.text,
  //       'email': _controllerEmail.text,
  //       'password': _controllerPassword.text,
  //     };

  //     dbRef!.push().set(user).whenComplete(() {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => const LoginScreen(),
  //         ),
  //       );
  //     });
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    const HeaderSigninSignup(title: 'Sign Up'),

                    // Name
                    CustomTextField(
                      controller: provider.controllerName,
                      hintText: 'Your Name',
                      imageAsset: 'assets/images/icon_name.png',
                      obscureText: false,
                    ),

                    genderInput(),

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

                    // Sign Up Button
                    AuthButtonGeneral(
                      backgroundColor: primaryColor,
                      title: 'Sign Up',
                      fontWeight: medium,
                      fontColor: whiteColor,
                      onTap: () {
                        provider.createUserWithEmailAndPassword();
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

                    // Sign In Button
                    AuthButtonGeneral(
                      backgroundColor: whiteColor,
                      title: 'Sign In',
                      fontWeight: medium,
                      fontColor: primaryColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
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
    });
  }
}
