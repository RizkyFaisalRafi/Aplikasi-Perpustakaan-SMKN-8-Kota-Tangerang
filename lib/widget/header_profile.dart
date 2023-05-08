import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../provider/auth_provider.dart';
import '../util/theme.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = AuthProvider().currentUser;

    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 80,
            backgroundImage: AssetImage('assets/images/icon_name.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            // 'Rizky Faisal Rafi',
            user?.uid ?? 'User Name',
            style: TextStyle(fontWeight: bold, fontSize: 20),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            user?.email ?? 'User Email',
            style: TextStyle(fontWeight: reguler, fontSize: 17),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Laki-laki',
            style: TextStyle(fontWeight: reguler, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
