// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use, avoid_print

import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:edu_vista_test/engblocs/course/course_bloc.dart';
import 'package:edu_vista_test/engblocs/lecture/lecture_bloc.dart';
import 'package:edu_vista_test/engcubid/eng_auth_cubit.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/ChatWindow.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/ChatsPage.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/SearchPage.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/categoriesPage.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/checkoutPage.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/myHomepage.dart';
// import 'package:edu_vista_test/pages/test.dart';
import 'package:edu_vista_test/utils/color_utilis.dart';
import 'package:edu_vista_test/firebase_options.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/PaymentcardPage.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/CartPage.dart';
// import 'package:edu_vista_test/pages/categoriesPage.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/ChoosePaymentPage.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/CourseDetailsPage.dart';
// import 'package:edu_vista_test/pages/HomePage.dart';
import 'package:edu_vista_test/pages/on%20start/onboarding_page.dart';
import 'package:edu_vista_test/pages/on%20start/splash_page.dart';
// import 'package:edu_vista_test/pages/forgotPasswordPage.dart';
// import 'package:edu_vista_test/pages/loginPage.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/ProfilePage.dart';
import 'package:edu_vista_test/pages/account/resetPasswordPage.dart';
import 'package:edu_vista_test/pages/account/resetpassword.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/myHomepage.dart';
import 'package:edu_vista_test/services/pref.service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



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
  // await dotenv.load(fileName: ".env");

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (ctx) => AuthCubit()),
      BlocProvider(create: (ctx) => CourseBloc()),
      BlocProvider(create: (ctx) => LectureBloc()),
    ],
    child:   DevicePreview(
      enabled: !kReleaseMode, // Enable only in debug mode
      builder: (context) => MyApp(), // Wrap your app
    ), 
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        useInheritedMediaQuery: true, // Required for Device Preview
      locale: DevicePreview.locale(context), // Add the locale
      builder: DevicePreview.appBuilder, // Wraps the app with Device Preview
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
         
          case CategoriesPage.id:
            return MaterialPageRoute(
                builder: (context) => CategoriesPage());

          default:
            return MaterialPageRoute(builder: (context) => myHomepage
            ());
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






// void main() {
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode, // Enable only in debug mode
//       builder: (context) => MyApp(), // Wrap your app
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       useInheritedMediaQuery: true, // Required for Device Preview
//       locale: DevicePreview.locale(context), // Add the locale
//       builder: DevicePreview.appBuilder, // Wraps the app with Device Preview
//       debugShowCheckedModeBanner: false,
//       home: SignupPage(),
//     );
//   }
// }

// class ResetPasswordScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Text(
//                 'Reset Password',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),
//             Text(
//               'Email',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w900,
                
//               ),
//             ),
//             SizedBox(height: 8),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'demo@mail.com',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//             ),
//             SizedBox(height: 40),
//             Center(
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Handle submit action
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.amber, // Set button color to yellow
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: Text(
//                     'SUBMIT',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
