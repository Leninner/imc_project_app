import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    if (mounted) {
      _redirect();
    }
    super.initState();
  }

  Future<void> _redirect() async {
    final session = supabase.auth.currentSession;

    await Future.delayed(Duration.zero, () {
      if (!mounted) {
        return;
      }

      if (session != null) {
        Navigator.of(context).popAndPushNamed(Routes.home);
      } else {
        Navigator.of(context).popAndPushNamed(Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SvgPicture.asset('assets/images/splash.svg'),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
