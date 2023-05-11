import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/transaction_data.dart';
import '../../util/theme.dart';

class TransactionAddData extends StatefulWidget {
  final TransactionData? transactionData;
  const TransactionAddData({super.key, this.transactionData});

  @override
  State<TransactionAddData> createState() => _TransactionAddDataState();
}

class _TransactionAddDataState extends State<TransactionAddData> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController studentsNameController = TextEditingController();
  TextEditingController nameBookController = TextEditingController();
  TextEditingController borrowDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();

  bool isLoading = false;

  // Create
  sendMemberOnFirebase() async {
    final studentName = studentsNameController.text;
    final List letters = studentName.split(''); // split untuk memisahkan kata
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
          await FirebaseFirestore.instance.collection('transaction_data').add({
        "student_name": studentsNameController.text,
        "name_book": nameBookController.text,
        "borrow_date": borrowDateController.text,
        "return_date": returnDateController.text,
        "search_keywords": searchKeywords,
      });
      studentsNameController = TextEditingController();
      nameBookController = TextEditingController();
      borrowDateController = TextEditingController();
      returnDateController = TextEditingController();

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

  // Update
  updateMember() async {
    final studentName = studentsNameController.text;
    final List letters = studentName.split(''); // split untuk memisahkan kata
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
          .collection('transaction_data')
          .doc(widget.transactionData!.docId)
          .update({
        "student_name": studentsNameController.text,
        "name_book": nameBookController.text,
        "borrow_date": borrowDateController.text,
        "return_date": returnDateController.text,
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
    if (widget.transactionData != null) {
      studentsNameController =
          TextEditingController(text: widget.transactionData!.studentsName);
      nameBookController =
          TextEditingController(text: widget.transactionData!.nameBook);
      borrowDateController =
          TextEditingController(text: widget.transactionData!.borrowDate);
      returnDateController =
          TextEditingController(text: widget.transactionData!.returnDate);
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
                  if (widget.transactionData != null) {
                    updateMember();
                    debugPrint("edit member");
                  } else {
                    sendMemberOnFirebase();
                    debugPrint("Success add new member");
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
                widget.transactionData != null ? 'Update Data' : 'Add Data',
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
        title: const Text('Tambah Data Peminjaman'),
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

                // Nama Anggota
                TextFormField(
                  controller: studentsNameController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the student's name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Nama Anggota",
                    hintText: "Nama Anggota",
                    prefixIcon: const Icon(Icons.person),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Judul Buku / Nama Buku
                TextFormField(
                  controller: nameBookController,
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
                    labelText: "Nama Buku/Judul Buku",
                    hintText: "Nama Buku/Judul Buku",
                    prefixIcon: const Icon(Icons.book_rounded),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Tanggal Pinjam
                TextFormField(
                  controller: borrowDateController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter borrow date';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Tanggal Pinjam",
                    hintText: "Tanggal Pinjam",
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Tanggal Kembali
                TextFormField(
                  controller: returnDateController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter return date';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Tanggal Kembali",
                    hintText: "Tanggal Kembali",
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
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
