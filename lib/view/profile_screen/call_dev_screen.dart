import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/theme.dart';

class CallDevScreen extends StatefulWidget {
  const CallDevScreen({Key? key}) : super(key: key);

  @override
  State<CallDevScreen> createState() => _CallDevScreenState();
}

class _CallDevScreenState extends State<CallDevScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
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
            const Text(
              'Untuk keluhan, kritik, dan saran dalam penggunaan aplikasi Perpustakaan, Anda dapat menghubungi:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                launchWhatsApp();
              },
              child: Card(
                child: ListTile(
                  title: const Text('0895 4128 92094'),
                  leading: Image.asset(
                    'assets/images/icon_wa.png',
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                launchPhone();
              },
              child: Card(
                child: ListTile(
                  title: const Text('0895 4128 92094'),
                  leading: Image.asset(
                    'assets/images/icon_calldev.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                launchEmail();
              },
              child: Card(
                child: ListTile(
                  title: const Text('rizkyfaisalrafi123@gmail.com'),
                  leading: Image.asset(
                    'assets/images/icon_email_dua.png',
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Hubungi kami pada saat jam kerja:\n09:00 - 16:00 WIB',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void launchWhatsApp() async {
    String url = "wa.me/62895412892094";
    final Uri whatsappUrl = Uri(scheme: 'https', path: url);

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  void launchPhone() async {
    final Uri url = Uri(scheme: 'tel', path: "0895412892094");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchEmail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'rizkyfaisalrafi123@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Send your Subject',
        'body': 'Your Description',
      }),
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
