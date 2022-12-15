import 'package:flutter/material.dart';

class AppBarWithTitle extends StatelessWidget implements PreferredSizeWidget {
  String? title;

  AppBarWithTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          title ?? "",
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
