// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use, avoid_print

import 'dart:ui';
import 'package:device_preview/device_preview.dart';
import 'package:edu_vista_test/pages/account/LoginPage.dart';
import 'package:edu_vista_test/utils/color_utilis.dart';
import 'package:edu_vista_test/firebase_options.dart';
import 'package:edu_vista_test/pages/cart/PaymentcardPage.dart';
import 'package:edu_vista_test/pages/on%20start/onboarding_page.dart';
import 'package:edu_vista_test/pages/on%20start/splash_page.dart';
import 'package:edu_vista_test/services/pref.service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('SUCCESS >>> FIREBASE CREATED');
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      scrollBehavior: _CustomScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorUtility.gbScaffold,
        fontFamily: ' PlusJakartaSans',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorUtility.main),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        final String routeName = settings.name ?? '';
        final dynamic data = settings.arguments;
        switch (routeName) {
          case PaymentcardPage.id:
            return MaterialPageRoute(builder: (context) => PaymentcardPage());

          case OnBoardingPage.id:
            return MaterialPageRoute(builder: (context) => OnBoardingPage());

          default:
            return MaterialPageRoute(builder: (context) =>SplashPage());
        }
      },
      initialRoute: SplashPage.id,
    );
  }
}

class _CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      };
}
