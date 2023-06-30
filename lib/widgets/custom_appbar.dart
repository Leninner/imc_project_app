import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.titleText,
  }) : super(key: key);

  final String? titleText;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          titleText ?? 'Titulo',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }
}