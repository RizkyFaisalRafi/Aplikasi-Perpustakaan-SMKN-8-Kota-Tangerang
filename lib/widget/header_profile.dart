import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/admin_data.dart';
import '../provider/auth_provider.dart';
import '../util/theme.dart';

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({super.key});

  @override
  State<HeaderProfile> createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  PlatformFile? pickedFile;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _uid;
  AdminData? adminData;

  void selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  void uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  void getData() async {
    User? user = AuthProvider().currentUser;
    _uid = user?.uid;
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('admin_data')
        .doc(_uid)
        .get();
    if (mounted) {
      setState(() {
        adminData = AdminData(
          name: snapshot.get('name'),
          email: snapshot.get('email'),
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? imagePath;

    return Center(
      child: Column(
        children: [
          pickedFile != null
              ? Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                    // image?: Image.file(File(pickedFile!.path!))
                  ),
                  child: Image.file(
                    File(pickedFile!.path!),
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://1.bp.blogspot.com/-FpuMqkbguNo/Xn4X3kZcrII/AAAAAAAAKJk/UjxkC2QK3AQ5EUWk0V1pexrKy0T8ND3wgCLcBGAsYHQ/s1600/kisspng-stock-photography-portrait-illustration-business-aura-financial-planning-build-a-profitable-busine-5cdaef32740dd9.0531019815578519544754.jpg'),
                        fit: BoxFit.cover,
                      )),
                ),
          ElevatedButton(
            onPressed: () async {
              selectFile();
            },
            child: const Text('Select Image'),
          ),
          ElevatedButton(
            onPressed: () async {
              uploadFile();
            },
            child: const Text('Upload Image'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            adminData?.name ?? 'Name',
            style: TextStyle(fontWeight: bold, fontSize: 20),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            adminData?.email ?? 'Email',
            style: TextStyle(fontWeight: reguler, fontSize: 17),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
