import 'package:flutter/material.dart';

class MemberDataScreen extends StatelessWidget {
  const MemberDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return const Card(
              child: ListTile(
                leading: FlutterLogo(
                  size: 60.0,
                ),
                title: Text('Nama Member'),
                subtitle: Text('NIS'),
                trailing: Text('Ubah'),
              ),
            );
          },
        ),
      ),
    );
  }
}
