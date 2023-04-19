import 'package:flutter/material.dart';

class BookDataScreen extends StatelessWidget {
  const BookDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Data'),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }

  Widget list() {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {},
      ),
    );
  }
}
