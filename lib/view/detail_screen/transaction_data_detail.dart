import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/home_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/report_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/transaction_screen.dart';

import '../../model/transaction_data.dart';
import '../../theme.dart';
import '../add_data/transaction_add_data.dart';

class TransactionDataDetail extends StatelessWidget {
  final TransactionData transactionData;

  const TransactionDataDetail({super.key, required this.transactionData});

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
              builder: (context) => TransactionAddData(
                transactionData: transactionData,
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

  /// Sudah Kembali Button
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
                  title: Text('Konfirmasi'),
                  content: Text('Apakah Anda yakin buku telah dikembalikan?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'TIDAK'),
                      child: const Text('TIDAK'),
                    ),
                    TextButton(
                      onPressed: () async {
                        /// Delete from collection transaction_data
                        try {
                          await FirebaseFirestore.instance
                              .collection('transaction_data')
                              .doc(transactionData.docId)
                              .delete();
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TransactionScreen(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Data Deleted Successfully'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } catch (e) {
                          print(e.toString());
                        }

                        /// Add Data to collection report_data
                        try {
                          FirebaseFirestore.instance
                              .collection('report_data')
                              .add({
                            "student_name": transactionData.studentsName,
                            "name_book": transactionData.nameBook,
                            "borrow_date": transactionData.borrowDate,
                            "return_date": transactionData.returnDate,
                          });
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      // Navigator.pop(context, 'YA'),
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
          'Sudah Kembali',
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
                trailing: Text(transactionData.studentsName ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Nama Buku/Judul Buku'),
                trailing: Text(transactionData.nameBook ?? 'Null'),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Tanggal Pinjam'),
                trailing: Text(transactionData.borrowDate ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Tanggal Kembali'),
                trailing: Text(transactionData.borrowDate ?? 'Null'),
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
