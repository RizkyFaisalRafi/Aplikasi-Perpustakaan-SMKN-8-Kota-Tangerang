import 'package:flutter/material.dart';
import '../util/theme.dart';

class MenuProfile extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final Function()? onTap;

  const MenuProfile({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                image,
                // 'assets/images/icon_calldev.png', //
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
                    title,
                    // 'Hubungi Developer',
                    style: TextStyle(fontWeight: bold, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    subTitle,
                    // 'Sampaikan kendala, kritik, dan saran Anda.',
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
}
