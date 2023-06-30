import 'package:flutter/material.dart';

import '../constants/app_routes.dart';
import '../widgets/custom_appbar.dart';

class ImcReportPage extends StatelessWidget {
  const ImcReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> GetPage() async {
      Navigator.of(context).pushReplacementNamed(Routes.imc);
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
        backgroundColor: Colors.purple[800],
        child: const Icon(Icons.arrow_back),
      ),
      appBar: const CustomAppBar(titleText: 'Reporte IMC'),
      body: Center(
        child: Column(

        ),
      ),
    );
  }
}
