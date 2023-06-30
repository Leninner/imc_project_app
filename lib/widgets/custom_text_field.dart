import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.keyboardType,
    this.controller,
    this.onTap,
    this.sizeButton,
  }) : super(key: key);

  final String? hintText;
  final double? sizeButton;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 24, vertical: sizeButton ?? 5.00),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF2F2F3),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF2C2B47),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
              errorText: _getErrorText(),
            ),
          ),
        ),
      ],
    );
  }

  String? _getErrorText() {
    if (controller?.text.isEmpty ?? true) {
      return null;
    }

    final isValidNumber = RegExp(r'^\d*\.?\d*$').hasMatch(controller!.text);
    if (!isValidNumber) {
      return 'Ingresa solo números';
    }

    return null;
  }
}
