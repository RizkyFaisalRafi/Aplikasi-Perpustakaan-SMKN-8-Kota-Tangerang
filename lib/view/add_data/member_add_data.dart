import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/member_data.dart';

import '../../util/theme.dart';

class MemberAddData extends StatefulWidget {
  final MemberData? memberData;

  const MemberAddData({super.key, this.memberData});

  @override
  State<MemberAddData> createState() => _MemberAddDataState();
}

class _MemberAddDataState extends State<MemberAddData> {
  final _formKey = GlobalKey<FormState>();
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController studentsNameController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController studentClassController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isLoading = false;

  // Create
  sendMemberOnFirebase() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await FirebaseFirestore.instance.collection('member_data').add({
      "student_name": studentsNameController.text,
      "nis": nisController.text,
      "place_of_birth": placeOfBirthController.text,
      "date_of_birth": dateOfBirthController.text,
      "gender": genderController.text,
      "student_class": studentClassController.text,
      "phone_number": phoneNumberController.text,
    });
    studentsNameController = TextEditingController();
    nisController = TextEditingController();
    placeOfBirthController = TextEditingController();
    dateOfBirthController = TextEditingController();
    genderController = TextEditingController();
    studentClassController = TextEditingController();
    phoneNumberController = TextEditingController();
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
  }

  // Update
  updateMember() async {
    try {
      FirebaseFirestore.instance
          .collection('member_data')
          .doc(widget.memberData!.docId)
          .update({
        "student_name": studentsNameController.text,
        "nis": nisController.text,
        "place_of_birth": placeOfBirthController.text,
        "date_of_birth": dateOfBirthController.text,
        "gender": genderController.text,
        "student_class": studentClassController.text,
        "phone_number": phoneNumberController.text,
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
    if (widget.memberData != null) {
      studentsNameController =
          TextEditingController(text: widget.memberData!.studentsName);
      nisController = TextEditingController(text: widget.memberData!.nis);
      placeOfBirthController =
          TextEditingController(text: widget.memberData!.placeOfBirth);
      dateOfBirthController =
          TextEditingController(text: widget.memberData!.dateOfBirth);
      genderController = TextEditingController(text: widget.memberData!.gender);
      studentClassController =
          TextEditingController(text: widget.memberData!.studentClass);
      phoneNumberController =
          TextEditingController(text: widget.memberData!.phoneNumber);
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
                  if (widget.memberData != null) {
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
                widget.memberData != null ? 'Update Data' : 'Add Data',
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
        title: const Text('Tambah Data Anggota'),
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
                    prefixIcon: const Icon(Icons.book_rounded),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // NIS
                TextFormField(
                  controller: nisController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter NIS';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "NIS",
                    hintText: "NIS",
                    prefixIcon: const Icon(Icons.person),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Tempat Lahir
                TextFormField(
                  controller: placeOfBirthController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter place of birth';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Tempat Lahir",
                    hintText: "Tempat Lahir",
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

                // Tanggal Lahir
                TextFormField(
                  controller: dateOfBirthController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter date of birth';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Tanggal Lahir",
                    hintText: "Tanggal Lahir",
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Jenis Kelamin
                TextFormField(
                  controller: genderController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Gender';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Gender",
                    hintText: "Gender",
                    prefixIcon: const Icon(Icons.format_list_numbered_rounded),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Kelas
                TextFormField(
                  controller: studentClassController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter class';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Kelas",
                    hintText: "Kelas",
                    prefixIcon: const Icon(Icons.format_list_numbered_rounded),
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Nomor Telephone Siswa
                TextFormField(
                  controller: phoneNumberController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Nomor Telepon",
                    hintText: "Nomor Telepon",
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
