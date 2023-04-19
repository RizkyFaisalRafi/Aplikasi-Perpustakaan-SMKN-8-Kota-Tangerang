
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('About Screen')),);
  }
}
