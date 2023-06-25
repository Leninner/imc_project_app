import 'package:flutter/material.dart';

class MainTitleWidget extends StatelessWidget {
  final String label;
  final double verticalPadding;

  const MainTitleWidget({
    super.key,
    required this.label,
    this.verticalPadding = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
