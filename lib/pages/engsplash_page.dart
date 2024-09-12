
import 'package:edu_vista_test/engutils/image_utility.dart';
import 'package:edu_vista_test/pages/categoriesPage.dart';
import 'package:edu_vista_test/pages/eng_login_page.dart';
import 'package:edu_vista_test/pages/enghome_page.dart';
import 'package:edu_vista_test/pages/engonboarding_page.dart';
import 'package:edu_vista_test/services/pref.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static String id = 'SplashPage';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageUtility.logo,
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  void _startApp() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      if (PreferencesService.isOnBoardingSeen) {
        if (FirebaseAuth.instance.currentUser != null) {
          Navigator.pushReplacementNamed(context, CategoriesPage.id);
        } else {
          Navigator.pushReplacementNamed(context, LoginPage.id);
        }
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingPage.id);
      }
    }
  }
}
