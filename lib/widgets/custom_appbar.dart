import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.titleText,
    this.iconButton,
  }) : super(key: key);

  final String? titleText;
  final IconButton? iconButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
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