import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/report_data.dart';
import '../../util/theme.dart';

class ReportDataDetail extends StatelessWidget {
  final ReportData reportData;

  const ReportDataDetail({super.key, required this.reportData});

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
          showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: const Text('Konfirmasi'),
                  content:
                      const Text('Apakah Anda yakin buku telah dikembalikan?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'TIDAK'),
                      child: const Text('TIDAK'),
                    ),
                    TextButton(
                      onPressed: () async {
                        /// Delete from collection report_data
                        try {
                          await FirebaseFirestore.instance
                              .collection('report_data')
                              .doc(reportData.docId)
                              .delete();
                          if (context.mounted) {
                            Navigator.pop(context, 'YA');
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Wrapper(),
                            //   ),
                            // );
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
                      child: const Text('YA'),
                    ),
                  ],
                )),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          'Hapus',
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
                trailing: Text(reportData.studentsName ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Nama Buku/Judul Buku'),
                trailing: Text(reportData.nameBook ?? 'Null'),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Tanggal Pinjam'),
                trailing: Text(reportData.borrowDate ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Tanggal Kembali'),
                trailing: Text(reportData.borrowDate ?? 'Null'),
              ),
            ),

            deleteButton(context),
          ],
        ),
      ),
    );
  }
}
