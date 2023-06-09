import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/provider/auth_provider.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/about_screen/about_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/auth_screen/auth_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/book_data_screen/book_data_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/member_data_screen/member_data_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/profile_screen/profile_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/report_screen/report_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/transaction_screen/transaction_screen.dart';
import 'package:provider/provider.dart';

import '../../util/theme.dart';
import '../../widget/header_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final User? user = AuthProvider().currentUser;

  @override
  void didChangeDependencies() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.updateEmailVerificationState();
    super.didChangeDependencies();
  }

  Widget? boddy() {
    switch (selectedIndex) {
      case 0:
        return menuHome();
      case 1:
        return const ReportScreen();
      case 2:
        return const ProfileScreen();
      default:
    }
    return null;
  }

  void _onItemTapped(int index) {
    setState(() {
      /// Akan bertambah 1 selectedIndexnya
      selectedIndex = index;
    });
  }

  Widget grid() {
    final List<String> menuItems = [
      'Book Data',
      'Member Data',
      'Transaction',
      'About'
    ];
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookDataScreen()),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MemberDataScreen()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TransactionScreen()),
                  );
                } else if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutScreen()),
                  );
                }
              },
              child: Card(
                elevation: 4.0,
                margin: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      index == 0
                          ? 'assets/images/icon_book.png'
                          : index == 1
                              ? 'assets/images/icon_member.png'
                              : index == 2
                                  ? 'assets/images/icon_transaction.png'
                                  : index == 3
                                      ? 'assets/images/icon_about.png'
                                      : 'assets/images/default_icon.png',
                      width: 50.0,
                      height: 50.0,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      menuItems[index],
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Menu Home
  Widget menuHome() {
    return SafeArea(
      child: Column(
        children: [
          const HeaderHomeScreen(),
          grid(),
          Image.asset(
            'assets/images/gradient_bottom.png',
            width: double.infinity,
          )
        ],
      ),
    );
  }

  /// Bottom NavBar
  Widget bottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check_circle), label: 'Report'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        onTap: _onItemTapped,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: const Color(0xffEFEFEF),
        body: provider.emailVerified ?? true
            ? boddy()
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Email Is Not Verified'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AuthScreen(),
                            ),
                          );
                          provider.logOut();
                        },
                        child: const Text('Log Out'))
                  ],
                ),
              ),
        bottomNavigationBar: bottomNav(),
      );
    });
  }
}
