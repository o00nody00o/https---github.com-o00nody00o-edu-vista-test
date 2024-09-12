// // ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, sized_box_for_whitespace, depend_on_referenced_packages, file_names

// import 'dart:math';
// import 'package:edu_vista_test/pages/forgotPasswordPage.dart';
// import 'package:edu_vista_test/pages/signUpPage.dart';
// import 'package:edu_vista_test/widgets/my_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
//   final email = TextEditingController();
//   final password = TextEditingController();

//   @override
//   void dispose() {
//     email.dispose();
//     password.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: WillPopScope(
//         onWillPop: () async => false,
//         child: Scaffold(
//           // key: scaffoldKey,
//           // backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
//           body: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               //++++++++++++++++++++++++++++++++++++++ app bar +++++++++++++++++++++++++++++++++++++++
//               // Align(
//               //   alignment: AlignmentDirectional(0, -1),
//               //   child: Padding(
//               //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
//               //     child: Row(
//               //       mainAxisSize: MainAxisSize.max,
//               //       mainAxisAlignment: MainAxisAlignment.end,
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         Flexible(
//               //           child: Align(
//               //             alignment: AlignmentDirectional(-1, 0),
//               //             child: Padding(
//               //               padding:
//               //                   EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//               //               child: Text('9:41',
//               //                   textAlign: TextAlign.center,
//               //                   style: TextStyle(
//               //                     fontFamily: 'Readex Pro',
//               //                     letterSpacing: 0,
//               //                     fontWeight: FontWeight.w600,
//               //                   )),
//               //             ),
//               //           ),
//               //         ),
//               //         Align(
//               //           alignment: AlignmentDirectional(0, 0),
//               //           child: Padding(
//               //             padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//               //             child: FaIcon(
//               //               FontAwesomeIcons.signal,
//               //               color: Colors.black,
//               //               size: 20,
//               //             ),
//               //           ),
//               //         ),
//               //         Align(
//               //           alignment: AlignmentDirectional(0, 0),
//               //           child: Padding(
//               //             padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//               //             child: Icon(
//               //               Icons.wifi_sharp,
//               //               color: Colors.black,
//               //               size: 24,
//               //             ),
//               //           ),
//               //         ),
//               //         Padding(
//               //           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
//               //           child: FaIcon(
//               //             FontAwesomeIcons.batteryFull,
//               //             color: Color(0xFFEFC539),
//               //             size: 24,
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//               //------------------------------- login title text ------------------------------------
            
//               Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 200),
//                   child: Text('Login',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontFamily: 'Readex Pro',
//                         fontSize: 25,
//                         fontWeight: FontWeight.w600,
//                       )),
//                 ),
             
//               //++++++++++++++++++++++++++++++++++++++++ textfields - email +++++++++++++++++++++++++++++++++++++++++
//               Align(
//                 alignment: AlignmentDirectional(0, 0),
//                 child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Align(
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 60),
//                             child: Container(
//                                 width: 330,
//                                 child: TextFieldsWidget(
//                                     controller: email,
//                                     keyboardType: TextInputType.emailAddress,
//                                     labelText: 'email')),
//                           ),
//                         ),
//                         //+++++++++++++++++++++++++++++++++++ password textfield ++++++++++++++++++++++++++++++++++++++++++++++++++
//                         Align(
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
//                             child: Container(
//                                 width: 330,
//                                 child: TextFieldsWidget(
//                                     controller: password,
//                                     keyboardType: TextInputType.visiblePassword,
//                                     labelText: 'password')),
//                           ),
//                         ),
//                         //++++++++++++++++++++++++++++++++++++++++  forgot password text button +++++++++++++++++++++++++++++++++
//                         Align(
//                           alignment: AlignmentDirectional(1, 0),
//                           child: Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 0, 10, 50),
//                               child: InkWell(
//                                 onTap: () => Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                            ForgotPasswordPage()),
//                                 ),
//                                 child: Text('Forgot password?',
//                                     textAlign: TextAlign.end,
//                                     style: TextStyle(
//                                       fontFamily: 'Readex Pro',
//                                       color: Color(0xFFEFC539),
//                                     )),
//                               )),
//                         ),
//                         //+++++++++++++++++++++++++++++++ login elevated button +++++++++++++++++++++++++++++++++++++++++
//                         Align(
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
//                               child: Container(
//                                 width: 327,
//                                 height: 52,
//                                 child: ElevatedButton(
//                                     style: ButtonStyle(
//                                       backgroundColor: WidgetStateProperty.all(
//                                           Color(0xFFEFC539)),
//                                     ),
//                                     onPressed: () {
//                                       print('Button pressed ...');
//                                     },
//                                     child: Text(
//                                       'Sign Up',
//                                       style: TextStyle(color: Colors.white),
//                                     )),
//                               )),
//                         ),
//                         //++++++++++++++++++++++++++++++++++  or login with text +++++++++++++++++++++++++++
//                         Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Align(
//                               alignment: AlignmentDirectional(0, 0),
//                               child: Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     16, 40, 16, 20),
//                                 child: Text('Or sign up with',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontFamily: 'Readex Pro',
//                                     )),
//                               ),
//                             ),
//                             //+++++++++++++++++++++++++++++ facebook button +++++++++++++++++++++++++++++++
//                             Align(
//                               alignment: AlignmentDirectional(0, 0),
//                               child: Padding(
//                                 padding:
//                                     EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Align(
//                                       alignment: AlignmentDirectional(0, 0),
//                                       child: Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 10, 16),
//                                         child: Container(
//                                           width: 230,
//                                           height: 44,
//                                           child: ElevatedButton(
//                                             style: ButtonStyle(
//                                               backgroundColor:
//                                                   WidgetStateProperty.all(
//                                                       Color(0xFF2D62FF)),
//                                             ),
//                                             onPressed: () {
//                                               null;
//                                             },
//                                             child: Row(
//                                               mainAxisSize: MainAxisSize.max,
//                                               children: [
//                                                 Icon(
//                                                   Icons.facebook,
//                                                   color: Colors.white,
//                                                   size: 30,
//                                                 ),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 Text(
//                                                   'Sign in with Facebook',
//                                                   style: TextStyle(
//                                                     fontFamily: 'Readex Pro',
//                                                     color: Colors.white,
//                                                     letterSpacing: 0,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     //+++++++++++++++++++++++++++++++++  google button +++++++++++++++++++++++++++++++
//                                     Align(
//                                       alignment: AlignmentDirectional(1, 0),
//                                       child: Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 0, 16),
//                                         child: Container(
//                                           width: 83,
//                                           height: 44,
//                                           // // child:
//                                           // Image.asset('assets/images/buttons.PNG'),
//                                           child: ElevatedButton(
//                                             onPressed: () {
//                                               print('Button pressed ...');
//                                             },
//                                             child: FaIcon(
//                                               FontAwesomeIcons.google,
//                                               size: 25,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )),
//               ),
//               //++++++++++++++++++++++++++++++++++++++ (don't have an account ) text ++++++++++++++++++++++++
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(65, 0, 0, 0),
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(16, 10, 0, 20),
//                       child: Text('Don\'t have an account?',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontFamily: 'Readex Pro',
//                             letterSpacing: 0,
//                           )),
//                     ),

//                     //++++++++++++++++++++++++++++++++++ login here clickable text +++++++++++++++++++++++++++++++++++
//                     Align(
//                       alignment: AlignmentDirectional(1, 0),
//                       child: Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(5, 0, 12, 10),
//                         child: InkWell(
//                           splashColor: Colors.transparent,
//                           focusColor: Colors.transparent,
//                           hoverColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           onTap: () async => await Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SignupPage()),
//                           ),
//                           child: Text('Sign Up Here',
//                               textAlign: TextAlign.end,
//                               style: TextStyle(
//                                 fontFamily: 'Readex Pro',
//                                 color: Color(0xFFEFC539),
//                                 letterSpacing: 0,
//                               )),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
