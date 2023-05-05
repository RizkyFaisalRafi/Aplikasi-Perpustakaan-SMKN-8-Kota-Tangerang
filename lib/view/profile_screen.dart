import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/theme.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/about_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/call_dev_screen.dart';

import '../auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget header() {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 80,
            backgroundImage: AssetImage('assets/images/icon_name.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Rizky Faisal Rafi',
            style: TextStyle(fontWeight: bold, fontSize: 20),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'rizkyfaisalrafi123@gmail.com',
            style: TextStyle(fontWeight: reguler, fontSize: 17),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Laki-laki',
            style: TextStyle(fontWeight: reguler, fontSize: 17),
          ),
        ],
      ),
    );
  }

  Widget hubDev() {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/call-dev-screen');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CallDevScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 28),
        child: Card(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  'assets/images/icon_calldev.png',
                  width: 56,
                  height: 56,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hubungi Developer',
                      style: TextStyle(fontWeight: bold, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Sampaikan kendala, kritik, dan saran Anda.',
                      style: TextStyle(fontWeight: reguler),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget aboutApp() {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/about-app-screen');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutScreen()),
        );
      },
      child: Card(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                'assets/images/icon_about_app.png',
                width: 56,
                height: 56,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tentang Aplikasi', style: TextStyle(fontWeight: bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Lihat informasi lengkap tentang aplikasi.',
                    style: TextStyle(fontWeight: reguler),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rateApp() {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                'assets/images/icon_rate_app.png',
                width: 56,
                height: 56,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rate Aplikasi', style: TextStyle(fontWeight: bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Menilai aplikasi di Google Play Store.',
                    style: TextStyle(fontWeight: reguler),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget logOut() {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/login-screen');
        signOut();
      },
      child: Card(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                'assets/images/icon_logout.png',
                width: 56,
                height: 56,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Keluar Akun', style: TextStyle(fontWeight: bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Klik untuk keluar dari akun Anda.',
                    style: TextStyle(fontWeight: reguler),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              header(),
              hubDev(),
              aboutApp(),
              rateApp(),
              logOut(),
              // Image.asset('assets/images/gradient_bottom.png')
            ],
          ),
        ),
      ),
    );
  }
}
