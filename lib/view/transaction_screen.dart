import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const FlutterLogo(
                  size: 60.0,
                ),
                title: const Text('Nama Peminjam'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('Tanggal Pinjam'),
                    SizedBox(
                      height: 4,
                    ),
                    Text('Tanggal Kembali'),
                  ],
                ),
                trailing: const Icon(Icons.check_circle_outline_rounded,
                    color: Colors.green),
              ),
            );
          },
        ),
      ),
    );
  }
}
