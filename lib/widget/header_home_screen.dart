import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/admin_data.dart';
import '../provider/auth_provider.dart';
import '../util/theme.dart';

class HeaderHomeScreen extends StatefulWidget {
  const HeaderHomeScreen({super.key});

  @override
  State<HeaderHomeScreen> createState() => _HeaderHomeScreenState();
}

class _HeaderHomeScreenState extends State<HeaderHomeScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  String? _uid;

  AdminData? adminData;

  void getData() async {
    User? user = AuthProvider().currentUser;
    _uid = user?.uid;
    // print(user?.displayName);
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('admin_data')
        .doc(_uid)
        .get();
    if (mounted) {
      setState(() {
        adminData = AdminData(
          name: snapshot.get('name'),
          email: snapshot.get('email'),
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = AuthProvider().currentUser;
    return Container(
      color: Colors.white,
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 24, fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    // 'Rizky Faisal Rafi',
                    adminData?.name ?? 'Name',
                    style: TextStyle(fontSize: 24, fontWeight: bold),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/logo_smkn_8_kotang.png',
              width: 100,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
