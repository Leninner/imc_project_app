import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool isBackButton;
  final String? toBackRouteName;

  const CustomAppBar({
    super.key,
    this.actions,
    required this.title,
    this.isBackButton = true,
    this.toBackRouteName,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      leading: widget.isBackButton
          ? IconButton(
              onPressed: () {
                if (widget.toBackRouteName == null) {
                  Navigator.of(context).pop();
                  return;
                }

                Navigator.of(context).pushReplacementNamed(
                  widget.toBackRouteName!,
                );
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            )
          : null,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: widget.actions,
    );
  }
}
