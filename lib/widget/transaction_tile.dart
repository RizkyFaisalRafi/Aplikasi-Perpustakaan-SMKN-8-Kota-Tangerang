import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/model/transaction_data.dart';

class TransactionTile extends StatelessWidget {
  final TransactionData transactionData;
  const TransactionTile({super.key, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const FlutterLogo(
          size: 60.0,
        ),
        title: Text(transactionData.studentsName ?? 'Null'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Buku: ${transactionData.nameBook ?? 'Null'}'),
            Text('Pinjam: ${transactionData.borrowDate ?? 'Null'}'),
            const SizedBox(
              height: 4,
            ),
            Text('Kembali: ${transactionData.returnDate ?? 'Null'}'),
          ],
        ),
        trailing: Image.asset(
          'assets/images/icon_cross.png',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
