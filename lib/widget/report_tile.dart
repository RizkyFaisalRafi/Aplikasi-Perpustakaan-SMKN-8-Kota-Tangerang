import 'package:flutter/material.dart';
import '../model/report_data.dart';

class ReportTile extends StatelessWidget {
  final ReportData reportData;
  const ReportTile({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const FlutterLogo(
          size: 60.0,
        ),
        title: Text(reportData.studentsName ?? 'Null'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Buku: ${reportData.nameBook ?? 'Null'}'),
            Text('Pinjam: ${reportData.borrowDate ?? 'Null'}'),
            const SizedBox(
              height: 4,
            ),
            Text('Kembali: ${reportData.returnDate ?? 'Null'}'),
          ],
        ),
        trailing: const Icon(Icons.check_circle_outline_rounded, color: Colors.green),
      ),
    );
  }
}
