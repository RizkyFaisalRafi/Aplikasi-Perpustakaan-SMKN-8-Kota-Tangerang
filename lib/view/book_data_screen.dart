import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/add_data/book_add_data.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/detail_screen/book_data_detail.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/widget/book_tile.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/book_data.dart';

class BookDataScreen extends StatelessWidget {
  const BookDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("book_data")
            .orderBy("book_name",
                descending:
                    false) // True sorting dari z-a alphabet, false sorting dari a-z alphabet
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                    yearsOfBook: snapshot.data!.docs[index]["years_of_book"],
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
