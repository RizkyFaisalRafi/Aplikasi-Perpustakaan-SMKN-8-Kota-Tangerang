import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/member_data.dart';
import '../../util/theme.dart';
import '../../widget/member_tile.dart';
import '../member_data_screen/member_add_data.dart';
import 'member_data_detail.dart';

class MemberDataScreen extends StatefulWidget {
  const MemberDataScreen({super.key});

  @override
  State<MemberDataScreen> createState() => _MemberDataScreenState();
}

class _MemberDataScreenState extends State<MemberDataScreen> {
  TextEditingController controllerSearch = TextEditingController();
  String? query = '';

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
      body: Column(
        children: [
          // Search
          Container(
            width: double.infinity,
            height: 100,
            color: whiteColor,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: const Color(0xffEFEFEF),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: controllerSearch,
                            obscureText: false,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: Color(0xff949494),
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                // searchFromFirebase(val);
                                query = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),

          const SizedBox(
            height: 12,
          ),

          Expanded(
            child: StreamBuilder(
              stream: (query != '' && query != null)
                  ? FirebaseFirestore
                      .instance // Menampilkan semua data berdasarkan search_keywords
                      .collection("member_data")
                      .where("search_keywords",
                          arrayContains: query!.toLowerCase())
                      .snapshots()
                  : FirebaseFirestore
                      .instance // Menampilkan semua data berdasarkan collection('member_data')
                      .collection('member_data')
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        MemberData memberData = MemberData(
                          docId: snapshot.data!.docs[index].id,
                          studentsName: snapshot.data!.docs[index]
                              ["student_name"],
                          nis: snapshot.data!.docs[index]["nis"],
                          placeOfBirth: snapshot.data!.docs[index]
                              ["place_of_birth"],
                          dateOfBirth: snapshot.data!.docs[index]
                              ["date_of_birth"],
                          gender: snapshot.data!.docs[index]["gender"],
                          studentClass: snapshot.data!.docs[index]
                              ["student_class"],
                          phoneNumber: snapshot.data!.docs[index]
                              ["phone_number"],
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
