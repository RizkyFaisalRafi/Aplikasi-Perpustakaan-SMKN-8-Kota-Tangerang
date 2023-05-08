import 'package:flutter/material.dart';
import '../model/member_data.dart';

class MemberTile extends StatelessWidget {
  final MemberData memberData;
  const MemberTile({super.key, required this.memberData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const FlutterLogo(
          size: 60.0,
        ),
        title: Text(memberData.studentsName ?? 'Null'),
        subtitle: Text(memberData.nis ?? 'Null'),
        trailing: const Icon(Icons.keyboard_arrow_right_outlined,
            color: Colors.green),
      ),
    );
  }
}
