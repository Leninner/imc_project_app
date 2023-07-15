import 'package:flutter/material.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/main.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:imc_project_app/widgets/custom_appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Perfil',
      ),
      body: buildBody(),
    );
  }

  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Información',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildFieldInfo("Nombre Completo", "Lenin Mazabanda"),
              buildFieldInfo("Correo Electrónico", "lenin@tinkin.one"),
              buildFieldInfo(
                "Fecha de Nacimiento",
                "12 de octubre de 1998",
              ),
              buildFieldInfo("Género", "Masculino"),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                label: 'Cerrar Sesión',
                onPressed: handleLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildFieldInfo(String label, String value) {
    return SizedBox(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleLogout() async {
    setState(() {
      _isLoading = true;
    });

    supabase.auth.signOut().then(
      (value) {
        Navigator.of(context).pushReplacementNamed(Routes.login);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Sesión cerrada correctamente',
            ),
            backgroundColor: Colors.green,
          ),
        );
      },
    ).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Error desconocido, por favor, inténtalo de nuevo',
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }).whenComplete(() {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
}
