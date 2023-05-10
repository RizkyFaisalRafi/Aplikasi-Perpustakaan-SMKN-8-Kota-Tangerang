import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/member_data.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/provider/services_member_provider.dart';
import 'package:provider/provider.dart';

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
  // TextEditingController studentsNameController = TextEditingController();
  // TextEditingController nisController = TextEditingController();
  // TextEditingController placeOfBirthController = TextEditingController();
  // TextEditingController dateOfBirthController = TextEditingController();
  // TextEditingController genderController = TextEditingController();
  // TextEditingController studentClassController = TextEditingController();
  // TextEditingController phoneNumberController = TextEditingController();
  bool isLoading = false;
  String? selectedGender = "";
  final genderlist = [
    "Pria",
    "Wanita",
  ];

  // @override
  // void initState() {
  //   if (widget.memberData != null) {
  //     studentsNameController =
  //         TextEditingController(text: widget.memberData!.studentsName);
  //     nisController = TextEditingController(text: widget.memberData!.nis);
  //     placeOfBirthController =
  //         TextEditingController(text: widget.memberData!.placeOfBirth);
  //     dateOfBirthController =
  //         TextEditingController(text: widget.memberData!.dateOfBirth);
  //     genderController = TextEditingController(text: widget.memberData!.gender);
  //     studentClassController =
  //         TextEditingController(text: widget.memberData!.studentClass);
  //     phoneNumberController =
  //         TextEditingController(text: widget.memberData!.phoneNumber);
  //   }
  //   super.initState();
  // }

  @override
  void initState() {
    selectedGender = genderlist[0];

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.memberData != null) {
      final firestoreServicesProvider =
          Provider.of<FirestoreServicesProvider?>(context, listen: false);
      firestoreServicesProvider?.studentsNameController =
          TextEditingController(text: widget.memberData!.studentsName);
      firestoreServicesProvider?.nisController =
          TextEditingController(text: widget.memberData!.nis);
      firestoreServicesProvider?.placeOfBirthController =
          TextEditingController(text: widget.memberData!.placeOfBirth);
      firestoreServicesProvider?.dateOfBirthController =
          TextEditingController(text: widget.memberData!.dateOfBirth);
      firestoreServicesProvider?.genderController =
          TextEditingController(text: widget.memberData!.gender);
      firestoreServicesProvider?.studentClassController =
          TextEditingController(text: widget.memberData!.studentClass);
      firestoreServicesProvider?.phoneNumberController =
          TextEditingController(text: widget.memberData!.phoneNumber);
    }
    super.didChangeDependencies();
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
          : Consumer<FirestoreServicesProvider>(
              builder: (context, provider, _) {
              return TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.memberData != null) {
                      provider.updateMember(
                          widget.memberData!, selectedGender, context);
                      debugPrint("edit member");
                    } else {
                      provider.sendMemberOnFirebase(selectedGender, context);
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
              );
            }),
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
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<FirestoreServicesProvider>(
                    builder: (context, provider, _) {
                  return Column(
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
                        controller: provider.studentsNameController,
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
                        controller: provider.nisController,
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
                        controller: provider.placeOfBirthController,
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
                        controller: provider.dateOfBirthController,
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

                      DropdownButtonFormField(
                        isExpanded: true,
                        value: selectedGender,
                        items: genderlist
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              selectedGender = val;
                            },
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Gender';
                          }
                          return null;
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.deepPurple,
                        ),
                        dropdownColor: Colors.deepPurple.shade50,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: "Jenis Kelamin",
                          hintText: "Jenis Kelamin",
                          prefixIcon: const Icon(FontAwesomeIcons.marsAndVenus),
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
                        controller: provider.studentClassController,
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
                          prefixIcon:
                              const Icon(Icons.format_list_numbered_rounded),
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
                        controller: provider.phoneNumberController,
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
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
