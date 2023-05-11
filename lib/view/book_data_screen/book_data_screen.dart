import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/util/theme.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/book_data_screen/book_add_data.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/book_data_screen/book_data_detail.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/widget/book_tile.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/book_data.dart';

class BookDataScreen extends StatefulWidget {
  const BookDataScreen({super.key});

  @override
  State<BookDataScreen> createState() => _BookDataScreenState();
}

class _BookDataScreenState extends State<BookDataScreen> {
  TextEditingController controllerSearch = TextEditingController();
  String? query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Book Data'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BookAddData(),
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
                      .collection("book_data")
                      .where("search_keywords",
                          arrayContains: query!.toLowerCase())
                      .snapshots()
                  : FirebaseFirestore
                      .instance // Menampilkan semua data berdasarkan collection('book_data')
                      .collection('book_data')
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
                        BookData bookData = BookData(
                          docId: snapshot.data!.docs[index].id,
                          bookName: snapshot.data!.docs[index]["book_name"],
                          author: snapshot.data!.docs[index]["author"],
                          publisher: snapshot.data!.docs[index]["publisher"],
                          yearsOfBook: snapshot.data!.docs[index]
                              ["years_of_book"],
                          isbn: snapshot.data!.docs[index]["isbn"],
                          numberOfBooks: snapshot.data!.docs[index]
                              ["number_of_books"],
                          racks: snapshot.data!.docs[index]["racks"],
                        );
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDataDetail(
                                  bookData: bookData,
                                ),
                              ),
                            );
                          },
                          child: BookTile(
                            bookData: bookData,
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
