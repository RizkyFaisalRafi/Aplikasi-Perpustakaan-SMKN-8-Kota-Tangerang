import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/book_data.dart';

import '../../util/theme.dart';

class BookAddData extends StatefulWidget {
  final BookData? bookData;

  const BookAddData({super.key, this.bookData});

  @override
  State<BookAddData> createState() => _BookAddDataState();
}

class _BookAddDataState extends State<BookAddData> {
  final _formKey = GlobalKey<FormState>();
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController bookNameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController yearsOfBookController = TextEditingController();
  TextEditingController isbnController = TextEditingController();
  TextEditingController numberOfBooksController = TextEditingController();
  TextEditingController racksController = TextEditingController();
  bool isLoading = false;

  sendBookOnFirebase() async {
    final bookName = bookNameController.text;
    final List letters = bookName.split(''); // split untuk memisahkan kata
    final List searchKeywords =
        []; // Inisialisasi list kosong untuk menampung search keywords
    String currentKeyword =
        ''; // Inisialisasi currentKeyword dengan string kosong

    try {
      for (var i = 0; i < letters.length; i++) {
        currentKeyword += letters[i]
            .toLowerCase(); // Menambahkan huruf baru ke currentKeyword dan menjadikan huruf kecil semua
        searchKeywords.add(
            currentKeyword); // Menambahkan currentKeyword ke dalam list searchKeywords
      }
      setState(() {
        isLoading = true;
      });
      final response =
          await FirebaseFirestore.instance.collection('book_data').add({
        "book_name": bookName,
        "author": authorController.text,
        "publisher": publisherController.text,
        "years_of_book": yearsOfBookController.text,
        "isbn": isbnController.text,
        "number_of_books": numberOfBooksController.text,
        "racks": racksController.text,
        "search_keywords": searchKeywords,
      });
      bookNameController = TextEditingController();
      authorController = TextEditingController();
      publisherController = TextEditingController();
      yearsOfBookController = TextEditingController();
      isbnController = TextEditingController();
      numberOfBooksController = TextEditingController();
      racksController = TextEditingController();
      setState(() {
        isLoading = false;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data Added Successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
      debugPrint(response.id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  updateBook() async {
    final bookName = bookNameController.text;
    final List letters = bookName.split(''); // split untuk memisahkan kata
    final List searchKeywords =
        []; // Inisialisasi list kosong untuk menampung search keywords
    String currentKeyword =
        ''; // Inisialisasi currentKeyword dengan string kosong

    try {
      for (var i = 0; i < letters.length; i++) {
        currentKeyword += letters[i]
            .toLowerCase(); // Menambahkan huruf baru ke currentKeyword dan menjadikan huruf kecil semua
        searchKeywords.add(
            currentKeyword); // Menambahkan currentKeyword ke dalam list searchKeywords
      }
      FirebaseFirestore.instance
          .collection('book_data')
          .doc(widget.bookData!.docId)
          .update({
        "book_name": bookNameController.text,
        "author": authorController.text,
        "publisher": publisherController.text,
        "years_of_book": yearsOfBookController.text,
        "isbn": isbnController.text,
        "number_of_books": numberOfBooksController.text,
        "racks": racksController.text,
        "search_keywords": searchKeywords,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data Updated Successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    if (widget.bookData != null) {
      bookNameController =
          TextEditingController(text: widget.bookData!.bookName);
      authorController = TextEditingController(text: widget.bookData!.author);
      publisherController =
          TextEditingController(text: widget.bookData!.publisher);
      yearsOfBookController =
          TextEditingController(text: widget.bookData!.yearsOfBook);
      isbnController = TextEditingController(text: widget.bookData!.isbn);
      numberOfBooksController =
          TextEditingController(text: widget.bookData!.numberOfBooks);
      racksController = TextEditingController(text: widget.bookData!.racks);
    }
    super.initState();
  }

  /// Add Data Button
  Widget addDataButton() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.bookData != null) {
                    updateBook();
                    debugPrint("edit book");
                  } else {
                    sendBookOnFirebase();
                    debugPrint("Success add new book");
                  }
                } else {}
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                widget.bookData != null ? 'Update Data' : 'Add Data',
                style: TextStyle(
                    fontSize: 16, fontWeight: medium, color: Colors.white),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Tambah Data Buku'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Photo
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    color: Colors.transparent,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo_smkn_8_kotang.png',
                      width: double.infinity,
                      height: 10,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nama Buku
                TextFormField(
                  controller: bookNameController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name book';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Nama Buku",
                    hintText: "Nama Buku",
                    prefixIcon: const Icon(Icons.book_rounded),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Pengarang
                TextFormField(
                  controller: authorController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter author book';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Pengarang",
                    hintText: "Pengarang",
                    prefixIcon: const Icon(Icons.person),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Penerbit
                TextFormField(
                  controller: publisherController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter publisher book';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Penerbit",
                    hintText: "Penerbit",
                    prefixIcon:
                        const Icon(Icons.published_with_changes_rounded),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Tahun Buku
                TextFormField(
                  controller: yearsOfBookController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter years of book';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Tahun Buku",
                    hintText: "Tahun Buku",
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // ISBN
                TextFormField(
                  controller: isbnController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ISBN book';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Nomor ISBN",
                    hintText: "Nomor ISBN",
                    prefixIcon: const Icon(Icons.format_list_numbered_rounded),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Jumlah Buku
                TextFormField(
                  controller: numberOfBooksController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of books';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Jumlah Buku",
                    hintText: "Jumlah Buku",
                    prefixIcon: const Icon(Icons.format_list_numbered_rounded),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Rak
                TextFormField(
                  controller: racksController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rack book';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Rak",
                    hintText: "Rak",
                    prefixIcon: const Icon(Icons.storage_rounded),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                addDataButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
