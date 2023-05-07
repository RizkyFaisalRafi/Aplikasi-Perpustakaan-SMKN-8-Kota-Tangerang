import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/detail_screen/book_data_detail.dart';

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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDataDetail(),
                  ),
                );
              },
              child: const Card(
                child: ListTile(
                  leading: FlutterLogo(
                    size: 60.0,
                  ),
                  title: Text('Nama Buku'),
                  subtitle: Text('Rak'),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined,
                      color: Colors.green),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return null;
      },
    );
  }
}
