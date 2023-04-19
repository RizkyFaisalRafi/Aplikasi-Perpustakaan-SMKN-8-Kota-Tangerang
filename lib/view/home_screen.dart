import 'package:flutter/material.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/about_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/book_data_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/member_data_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/profile_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/report_screen.dart';
import 'package:perpustakaan_smkn_8_kota_tangerang/view/transaction_screen.dart';

import '../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

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

  /// Header
  Widget header() {
    return Container(
      color: Colors.white,
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 24, fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Rizky Faisal Rafi',
                    style: TextStyle(fontSize: 24, fontWeight: bold),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/logo_smkn_8_kotang.png',
              width: 100,
              height: 100,
            )
          ],
        ),
      ),
    );
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
          header(),
          grid(),
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
    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      body: boddy(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
