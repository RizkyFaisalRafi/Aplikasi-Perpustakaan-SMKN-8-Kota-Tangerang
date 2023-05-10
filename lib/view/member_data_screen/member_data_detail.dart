import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/member_data.dart';
import '../../util/theme.dart';
import 'member_add_data.dart';

class MemberDataDetail extends StatelessWidget {
  final MemberData memberData;

  const MemberDataDetail({super.key, required this.memberData});

  /// Change Button
  Widget changeButton(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16, bottom: 12, left: 16, right: 16),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberAddData(
                memberData: memberData,
              ),
            ),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          'Ubah',
          style:
              TextStyle(fontSize: 16, fontWeight: medium, color: Colors.white),
        ),
      ),
    );
  }

  /// Delete Button
  Widget deleteButton(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8, bottom: 20, left: 16, right: 16),
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
        onPressed: () async {
          try {
            await FirebaseFirestore.instance
                .collection('member_data')
                .doc(memberData.docId)
                .delete();
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data Deleted Successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          'Delete',
          style:
              TextStyle(fontSize: 16, fontWeight: medium, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            Center(
              child: Image.asset(
                'assets/images/logo_smkn_8_kotang.png',
                width: double.infinity,
                // height: 270,
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Card(
              child: ListTile(
                title: const Text('Nama Siswa'),
                trailing: Text(memberData.studentsName ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('NIS'),
                trailing: Text(memberData.nis ?? 'Null'),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Tempat Lahir'),
                trailing: Text(memberData.placeOfBirth ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Tanggal Lahir'),
                trailing: Text(memberData.dateOfBirth ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Jenis Kelamin'),
                trailing: Text(memberData.gender ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Kelas'),
                trailing: Text(memberData.studentClass ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Nomor Telepon'),
                trailing: Text(memberData.phoneNumber ?? 'Null'),
              ),
            ),

            changeButton(context),
            deleteButton(context),
          ],
        ),
      ),
    );
  }
}
