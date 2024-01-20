import 'package:employee/constants/common_colors.dart';
import 'package:flutter/material.dart';

class RoleSheet extends StatelessWidget {
  static const roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];
  const RoleSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: roles.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(roles[index]),
          titleAlignment: ListTileTitleAlignment.center,
          onTap: () => Navigator.pop(context, roles[index]),
        ),
        separatorBuilder: (_, __) => const Divider(
          color: CommonColors.borderColor,
        ),
      ),
    );
  }
}
