import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/admin_data.dart';
import '../provider/auth_provider.dart';
import '../util/theme.dart';

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({super.key});

  @override
  State<HeaderProfile> createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _uid;
  AdminData? adminData;

  void getData() async {
    User? user = _auth.currentUser;
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

    // final FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference users = firestore.collection('admin_data');
    // DocumentReference userDoc = users.doc(user?.uid);
    // userDoc.get().then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     print('Name: ${documentSnapshot.data()!['name']}');
    //   } else {
    //     print('Document does not exist on the database');
    //   }
    // });

    // final User? user = AuthProvider().currentUser;

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
            // user?.uid ?? 'User Name',
            adminData?.name ?? 'Name',
            style: TextStyle(fontWeight: bold, fontSize: 20),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            adminData?.email ?? 'Email',
            // user?.email ?? 'User Email',
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
