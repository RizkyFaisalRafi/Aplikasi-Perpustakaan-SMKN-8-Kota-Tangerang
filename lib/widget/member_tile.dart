import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/book_data.dart';

class MemberTile extends StatelessWidget {
  final BookData bookData;
  const MemberTile({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const FlutterLogo(
          size: 60.0,
        ),
        title: Text(bookData.bookName??'Null'),
        subtitle: Text(bookData.racks??'Null'),
        trailing:
            const Icon(Icons.keyboard_arrow_right_outlined, color: Colors.green),
      ),
    );
  }
}
