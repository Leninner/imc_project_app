import 'package:flutter/material.dart';

import '../constants/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> GetImcPage() async {
      Navigator.of(context).pushReplacementNamed(Routes.imc);
    }
    Future<void> GetImcReportPage() async {
      Navigator.of(context).pushReplacementNamed(Routes.imcReport);
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Home Page'),
            ElevatedButton(
              onPressed: GetImcPage,
              child: const Text('Go to IMC Page'),
            ),
            ElevatedButton(
              onPressed: GetImcReportPage,
              child: const Text('Go to IMC Report Page'),
            ),
          ],
        ),
      ),
    );
  }
}
