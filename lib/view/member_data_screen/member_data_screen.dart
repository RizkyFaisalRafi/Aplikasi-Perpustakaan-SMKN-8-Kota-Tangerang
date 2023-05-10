import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/member_data.dart';
import '../../util/theme.dart';
import '../../widget/member_tile.dart';
import '../member_data_screen/member_add_data.dart';
import 'member_data_detail.dart';

class MemberDataScreen extends StatelessWidget {
  const MemberDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Member Data'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MemberAddData(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("member_data")
            .orderBy("student_name", descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  MemberData memberData = MemberData(
                    docId: snapshot.data!.docs[index].id,
                    studentsName: snapshot.data!.docs[index]["student_name"],
                    nis: snapshot.data!.docs[index]["nis"],
                    placeOfBirth: snapshot.data!.docs[index]["place_of_birth"],
                    dateOfBirth: snapshot.data!.docs[index]["date_of_birth"],
                    gender: snapshot.data!.docs[index]["gender"],
                    studentClass: snapshot.data!.docs[index]["student_class"],
                    phoneNumber: snapshot.data!.docs[index]["phone_number"],
                  );
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MemberDataDetail(
                            memberData: memberData,
                          ),
                        ),
                      );
                    },
                    child: MemberTile(
                      memberData: memberData,
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
