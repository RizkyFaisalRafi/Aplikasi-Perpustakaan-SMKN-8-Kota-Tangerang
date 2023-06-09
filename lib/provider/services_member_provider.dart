import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/member_data_screen/member_data_screen.dart';

import '../model/member_data.dart';

class FirestoreServicesProvider with ChangeNotifier {
  bool isLoading = false;

  TextEditingController studentsNameController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController studentClassController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // Create member_data
  Future<void> sendMemberOnFirebase(
      String? gender, BuildContext context) async {
    final studentName = studentsNameController.text;
    final List letters = studentName.split('');
    final List searchKeywords =
        []; // Inisialisasi list kosong untuk menampung search keywords
    String currentKeyword =
        ''; // Inisialisasi currentKeyword dengan string kosong

    for (var i = 0; i < letters.length; i++) {
      currentKeyword += letters[i]
          .toLowerCase(); // Menambahkan huruf baru ke currentKeyword dan menjadikan huruf kecil semua
      searchKeywords.add(
          currentKeyword); // Menambahkan currentKeyword ke dalam list searchKeywords
    }
    isLoading = true;

    final response =
        await FirebaseFirestore.instance.collection('member_data').add({
      "student_name": studentName,
      "nis": nisController.text,
      "place_of_birth": placeOfBirthController.text,
      "date_of_birth": dateOfBirthController.text,
      "gender": gender,
      "student_class": studentClassController.text,
      "phone_number": phoneNumberController.text,
      "search_keywords": searchKeywords,
    });
    studentsNameController = TextEditingController();
    nisController = TextEditingController();
    placeOfBirthController = TextEditingController();
    dateOfBirthController = TextEditingController();
    genderController = TextEditingController();
    studentClassController = TextEditingController();
    phoneNumberController = TextEditingController();

    isLoading = false;

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data Added Successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
    notifyListeners();
    debugPrint(response.id);
    studentsNameController.clear();
  }

  // Update member_data
  Future<void> updateMember(
      MemberData memberData, String? gender, BuildContext context) async {
    final studentName = studentsNameController.text;
    final List letters = studentName.split('');
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
          .collection('member_data')
          .doc(memberData.docId)
          .update({
        "student_name": studentsNameController.text,
        "nis": nisController.text,
        "place_of_birth": placeOfBirthController.text,
        "date_of_birth": dateOfBirthController.text,
        "gender": gender,
        "student_class": studentClassController.text,
        "phone_number": phoneNumberController.text,
        "search_keywords": searchKeywords,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data Updated Successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MemberDataScreen()));
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();

    studentsNameController.clear();
    nisController.clear();
    placeOfBirthController.clear();
    dateOfBirthController.clear();
    genderController.clear();
    studentClassController.clear();
    phoneNumberController.clear();
  }
}
