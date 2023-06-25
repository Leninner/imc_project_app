import 'package:flutter/material.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/main.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:imc_project_app/widgets/input_field.dart';
import 'package:imc_project_app/widgets/main_title_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void clearFields() {
    _nameController.clear();
    _lastNameController.clear();
    _birthDateController.clear();
    _genderController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _handleSignUp() async {
    formKey.currentState?.validate();
    setState(() {
      _isLoading = true;
    });

    await supabase.auth.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      data: {
        'name': _nameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'birthday': _birthDateController.text.trim(),
        'gender': _genderController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
      },
    ).then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Inicia sesión con tu nueva cuenta',
          ),
          backgroundColor: Colors.green,
        ),
      );

      clearFields();
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString().contains('400')
                ? 'El correo ya está registrado'
                : 'Error desconocido, intenta de nuevo',
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        appBar: null,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SafeArea(
            child: Column(
              children: [
                const MainTitleWidget(label: 'Crear Cuenta'),
                buildRegisterForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form buildRegisterForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputField(
            label: 'Nombre *',
            controller: _nameController,
            validator: () {
              final RegExp onlyLettersRegexp = RegExp(r'^[a-zA-Z\s]+$');

              if (!onlyLettersRegexp.hasMatch(_nameController.text)) {
                return 'El nombre solo puede contener letras';
              }
            },
          ),
          const SizedBox(height: 18),
          InputField(
            label: 'Apellido *',
            controller: _lastNameController,
            validator: () {
              final RegExp onlyLettersRegexp = RegExp(r'^[a-zA-Z\s]+$');
              if (!onlyLettersRegexp.hasMatch(_lastNameController.text)) {
                return 'El apellido solo puede contener letras';
              }
            },
          ),
          const SizedBox(height: 18),
          InputField(
            label: 'Fecha de nacimiento *',
            type: TextInputType.datetime,
            controller: _birthDateController,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (date != null) {
                _birthDateController.text =
                    date.toLocal().toString().split(' ')[0];
              }
            },
            readOnly: true,
          ),
          const SizedBox(height: 18),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Género *',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Masculino',
                child: Text('Masculino'),
              ),
              DropdownMenuItem(
                value: 'Femenino',
                child: Text('Femenino'),
              ),
              DropdownMenuItem(
                value: 'Otro',
                child: Text('Otro'),
              ),
            ],
            onChanged: (value) {
              _genderController.text = value.toString();
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null) {
                return 'Selecciona una opción';
              }

              return null;
            },
          ),
          const SizedBox(height: 18),
          InputField(
            label: 'Correo electrónico *',
            type: TextInputType.emailAddress,
            controller: _emailController,
            validator: () {
              final RegExp emailRegexp = RegExp(
                r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+(\.[a-zA-Z]+)?$',
              );

              if (!emailRegexp.hasMatch(_emailController.text)) {
                return 'El correo electrónico no es válido';
              }
            },
          ),
          const SizedBox(height: 18),
          InputField(
            label: 'Contraseña *',
            type: TextInputType.visiblePassword,
            controller: _passwordController,
            validator: () {
              if (_passwordController.text.length < 6) {
                return 'Debe contener al menos 6 caractéres';
              }
            },
          ),
          const SizedBox(height: 18),
          ButtonWidget(onPressed: _handleSignUp, label: 'Crear Cuenta'),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.login);
            },
            child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
          ),
        ],
      ),
    );
  }
}
