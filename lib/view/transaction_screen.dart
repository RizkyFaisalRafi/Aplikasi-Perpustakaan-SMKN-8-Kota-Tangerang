import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/transaction_data.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/widget/transaction_tile.dart';

import '../theme.dart';
import 'add_data/transaction_add_data.dart';
import 'detail_screen/transaction_data_detail.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Transaction'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TransactionAddData(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("transaction_data")
            .orderBy("student_name", descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  TransactionData transactionData = TransactionData(
                    studentsName: snapshot.data!.docs[index]["student_name"],
                    nameBook: snapshot.data!.docs[index]["name_book"],
                    borrowDate: snapshot.data!.docs[index]["borrow_date"],
                    returnDate: snapshot.data!.docs[index]["return_date"],
                    docId: snapshot.data!.docs[index].id,
                  );
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionDataDetail(
                            transactionData: transactionData,
                          ),
                        ),
                      );
                    },
                    child: TransactionTile(
                      transactionData: transactionData,
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
