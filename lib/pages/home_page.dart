import 'package:flutter/material.dart';

import '../constants/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> GetPage() async {
      Navigator.of(context).pushReplacementNamed(Routes.imc);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Routes.profile,
                );
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Home Page'),
              ElevatedButton(
                onPressed: GetPage,
                child: const Text('Register IMC'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    Routes.registerFood,
                  );
                },
                child: const Text('Registro de alimentos'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    Routes.imcReport,
                  );
                },
                child: const Text('Ver registros de IMC'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
