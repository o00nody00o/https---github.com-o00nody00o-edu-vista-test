// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, sized_box_for_whitespace, depend_on_referenced_packages, file_names

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista_test/pages/LoginPage.dart';
import 'package:edu_vista_test/pages/forgotPasswordPage.dart';
import 'package:edu_vista_test/pages/signUpPage.dart';
import 'package:edu_vista_test/widgets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();

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
//                                     controller: _emailController,
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
//                                     controller: _passwordController,
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
//                                 builder: (context) => SignUpPage()),
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





class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _errorMessage;

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = "Passwords do not match!";
      });
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()), // Navigate to login page
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldsWidget(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  labelText: 'Full Name ...',hiddenPassword: false,),
              SizedBox(
                height: 20,
              ),
              TextFieldsWidget(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email ...',hiddenPassword: false
              ),
              SizedBox(
                height: 20,
              ),

              TextFieldsWidget(
                  controller: _passwordController,
                  labelText: 'Password',hiddenPassword: true,),
              SizedBox(
                height: 20,
              ),

              TextFieldsWidget(
                controller: _confirmPasswordController,
                labelText: 'Confirm Password',hiddenPassword: true,
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 190),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  ),
                  child: Text('Forgot password?',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Color(0xFFEFC539),
                        letterSpacing: 0,
                      )),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 327,
                height: 52,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xFFEFC539)),
                  ),
                  onPressed: _signUp,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 20),

              Text('Or sign up with',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0,
                  )),
              SizedBox(height: 20),

              Container(
                width: 327,
                height: 45,
                child: Image.asset(
                  'assets/images/face and google.PNG',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 20),

              Padding(
                padding: EdgeInsetsDirectional.only(top: 5, start: 40),
                child: Row(children: [
                  Center(
                    child: Text('You already have an account?',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        )),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () async => await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ),
                    child: Text('Login Here',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFFEFC539),
                          letterSpacing: 0,
                        )),
                  ),
                ]),
              ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
