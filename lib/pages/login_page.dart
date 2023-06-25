import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/main.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:imc_project_app/widgets/input_field.dart';
import 'package:imc_project_app/widgets/main_title_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await supabase.auth
          .signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )
          .then(
        (value) {
          const SnackBar snackBar = SnackBar(
            content: Text('Bienvenido'),
            backgroundColor: Colors.green,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          _emailController.clear();
          _passwordController.clear();

          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
      );
    } on AuthException catch (_) {
      final SnackBar snackBar = SnackBar(
        content: const Text('Credenciales incorrectas'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      // final session = data.session;

      // if (session != null) {
      //   _redirecting = true;
      //   Navigator.of(context).pushReplacementNamed('/account');
      // }
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SafeArea(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SvgPicture.asset('assets/images/login_image.svg'),
              ),
              const MainTitleWidget(
                label: 'Inicias Sesión',
                verticalPadding: 10,
              ),
              const SizedBox(height: 18),
              buildLoginForm(),
            ]),
          ),
        ),
      ),
    );
  }

  Form buildLoginForm() {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 18),
          InputField(
            label: 'Correo Electrónico *',
            controller: _emailController,
          ),
          const SizedBox(height: 18),
          InputField(
            label: 'Contraseña *',
            controller: _passwordController,
          ),
          const SizedBox(height: 18),
          ButtonWidget(onPressed: _signIn, label: 'Iniciar Sesión'),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.register);
            },
            child: const Text('¿No tienes cuenta? Regístrate'),
          ),
        ],
      ),
    );
  }
}
