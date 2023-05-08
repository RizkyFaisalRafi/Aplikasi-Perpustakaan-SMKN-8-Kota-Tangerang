import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/book_data.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/add_data/book_add_data.dart';

import '../../theme.dart';

class BookDataDetail extends StatelessWidget {
  final BookData bookData;

  const BookDataDetail({super.key, required this.bookData});

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
              builder: (context) => BookAddData(
                bookData: bookData,
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
                .collection('book_data')
                .doc(bookData.docId)
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
            print(e.toString());
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
                title: const Text('Nama Buku'),
                trailing: Text(bookData.bookName ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Pengarang'),
                trailing: Text(bookData.author ?? 'Null'),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Penerbit'),
                trailing: Text(bookData.publisher ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Tahun Buku'),
                trailing: Text(bookData.yearsOfBook ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('ISBN'),
                trailing: Text(bookData.isbn ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Jumlah Buku'),
                trailing: Text(bookData.numberOfBooks ?? 'Null'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Rak'),
                trailing: Text(bookData.racks ?? 'Null'),
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
