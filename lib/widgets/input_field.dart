import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final TextInputType type;
  final IconButton? suffixIcon;
  final TextEditingController controller;
  final Function()? onTap;
  final bool readOnly;
  final Function()? validator;

  const InputField({
    super.key,
    required this.label,
    this.type = TextInputType.name,
    this.suffixIcon,
    required this.controller,
    this.onTap,
    this.readOnly = false,
    this.validator,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      style: MaterialStateTextStyle.resolveWith(
        (states) => const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      obscureText:
          widget.label.contains('Contraseña') ? !_passwordVisible : false,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        suffixIcon: widget.label.contains('Contraseña')
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese su ${widget.label.toLowerCase().replaceFirst('*', '')}';
        }

        if (widget.validator != null) {
          return widget.validator!();
        }

        return null;
      },
    );
  }
}
