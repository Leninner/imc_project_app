import 'package:flutter/material.dart';
import 'package:imc_project_app/widgets/stack_over_widget.dart';
import 'package:imc_project_app/widgets/custom_appbar.dart';

import '../constants/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Dashboard',
          actions: [
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Routes.profile,
                );
              },
            ),
          ],
          isBackButton: false,
        ),
        body: const Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: StackOverWidget(),
          ),
        ),
      ),
    );
  }
}
