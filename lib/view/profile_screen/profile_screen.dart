import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/about_screen/about_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/profile_screen/call_dev_screen.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../widget/menu_profile.dart';
import '../../widget/header_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedValue;
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
              const HeaderProfile(),
              const SizedBox(
                height: 28,
              ),

              // Hubungi Developer
              MenuProfile(
                image: 'assets/images/icon_calldev.png',
                title: 'Hubungi Developer',
                subTitle: 'Sampaikan kendala, kritik, dan saran Anda.',
                onTap: () {
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CallDevScreen(),
                      ),
                    );
                  }
                },
              ),

              // Tentang Aplikasi
              MenuProfile(
                image: 'assets/images/icon_about_app.png',
                title: 'Tentang Aplikasi',
                subTitle: 'Lihat informasi lengkap tentang aplikasi.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  );
                },
              ),

              // Rate Aplikasi
              MenuProfile(
                image: 'assets/images/icon_rate_app.png',
                title: 'Rate Aplikasi',
                subTitle: 'Menilai aplikasi di Google Play Store.',
                onTap: () {},
              ),
              
              DropdownButton<String?>(
                  isExpanded: true,
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  items: ["Toyota", "Daihatsu", "Honda", "Suzuki"]
                      .map<DropdownMenuItem<String?>>(
                        (e) => DropdownMenuItem(
                          child: Text(e.toString()),
                          value: e,
                        ),
                      )
                      .toList()),

              // Keluar Akun
              Consumer<AuthProvider>(builder: (context, provider, _) {
                return MenuProfile(
                  image: 'assets/images/icon_logout.png',
                  title: 'Keluar Akun',
                  subTitle: 'Klik untuk keluar dari akun Anda.',
                  onTap: () => provider.logOut(),
                );
              }),
              // Image.asset('assets/images/gradient_bottom.png')
            ],
          ),
        ),
      ),
    );
  }
}
