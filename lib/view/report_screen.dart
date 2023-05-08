import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/report_data.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/util/theme.dart';

import '../widget/report_tile.dart';
import 'detail_screen/report_data_detail.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("report_data")
              .orderBy("student_name", descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    ReportData reportData = ReportData(
                      docId: snapshot.data!.docs[index].id,
                      studentsName: snapshot.data!.docs[index]["student_name"],
                      nameBook: snapshot.data!.docs[index]["name_book"],
                      borrowDate: snapshot.data!.docs[index]["borrow_date"],
                      returnDate: snapshot.data!.docs[index]["return_date"],
                    );
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportDataDetail(
                              reportData: reportData,
                            ),
                          ),
                        );
                      },
                      child: ReportTile(
                        reportData: reportData,
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
          }),
    );
  }
}
