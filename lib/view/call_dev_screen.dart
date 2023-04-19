import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CallDevScreen extends StatefulWidget {
  const CallDevScreen({Key? key}) : super(key: key);

  @override
  State<CallDevScreen> createState() => _CallDevScreenState();
}

class _CallDevScreenState extends State<CallDevScreen> {
  final Uri whatsappUrl =
      Uri.parse('https://api.whatsapp.com/send?phone=62895412892094');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Developer',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Untuk keluhan, kritik, dan saran dalam penggunaan aplikasi Perpustakaan, Anda dapat menghubungi:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () => launchUrl(whatsappUrl),
              child: Card(
                child: ListTile(
                  title: Text('0895 4128 92094'),
                  leading: FlutterLogo(),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('rizkyfaisalrafi123@gmail.com'),
                leading: FlutterLogo(),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Hubungi kami pada saat jam kerja:\n06:00 - 16:00 WIB',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void launchWhatsApp() async {
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
