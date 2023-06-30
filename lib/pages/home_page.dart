import 'package:flutter/material.dart';

import '../constants/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) {
    Future<void> GetPage() async {
      Navigator.of(context).pushReplacementNamed(Routes.imc);
    }
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Home Page'),
            ElevatedButton(
              onPressed: GetPage,
              child: const Text('Get Page'),
            ),
          ],
        ),
      ),
    );
  }
}
