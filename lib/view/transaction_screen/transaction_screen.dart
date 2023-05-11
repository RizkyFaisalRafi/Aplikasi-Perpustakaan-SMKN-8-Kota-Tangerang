import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/transaction_data.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/widget/transaction_tile.dart';
import '../../util/theme.dart';
import 'transaction_add_data.dart';
import 'transaction_data_detail.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TextEditingController controllerSearch = TextEditingController();
  String? query = '';

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

          // List
          Expanded(
            child: StreamBuilder(
              stream: (query != '' && query != null)
                  ? FirebaseFirestore
                      .instance // Menampilkan semua data berdasarkan search_keywords
                      .collection("transaction_data")
                      .where("search_keywords",
                          arrayContains: query!.toLowerCase())
                      .snapshots()
                  : FirebaseFirestore
                      .instance // Menampilkan semua data berdasarkan collection('member_data')
                      .collection('transaction_data')
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
                        TransactionData transactionData = TransactionData(
                          studentsName: snapshot.data!.docs[index]
                              ["student_name"],
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
