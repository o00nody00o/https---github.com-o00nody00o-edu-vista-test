// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_import, must_be_immutable, unused_import, prefer_const_constructors_in_immutables, unused_field, avoid_unnecessary_containers, avoid_print, file_names, unnecessary_string_escapes, use_build_context_synchronously, sort_child_properties_last

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista_test/engutils/color_utilis.dart';
import 'package:edu_vista_test/pages/categoriesPage.dart';
import 'package:edu_vista_test/pages/eng_login_page.dart';
import 'package:edu_vista_test/pages/forgotPasswordPage.dart';
import 'package:edu_vista_test/pages/loginPage.dart';
import 'package:edu_vista_test/widgets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupPage extends StatefulWidget {
  static const String id = 'SignUpPAge';
  SignupPage({
    super.key,
  });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullnameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _confirmpasswordController.dispose();
    _passwordController.dispose();
    _fullnameController.dispose();
    super.dispose();
  }

//+++++++++++++++++++++++++++++++++++++++++++++++  logic ++++++++++++++++++++++++++++++++++++++++++
  //is the password correct ?
  bool passwordIsRight() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

//create user data and adding to firestore
  Future signUp() async {
    if (passwordIsRight()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
    //calling function for adding data to the firestore
    addUserData(
        _fullnameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _confirmpasswordController.text.trim());

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Signed up successfully \^ _ ^/',
          style: TextStyle(
              color: const Color.fromARGB(255, 37, 153, 2),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  //now add the user's data
  Future addUserData(String fullname, String email, String password,
      String confirmpassword) async {
    try {
      await FirebaseFirestore.instance.collection('data').add({
        "full name": fullname,
        "email": email,
        "password": password,
        ' confirm password ': confirmpassword,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CategoriesPage()),
      );

      print("success: data added to firestore");
    } catch (e) {
      print("Failed adding data to firestore >>>>> $e");
      return SnackBar(
        content: Text(
          'sign up failed : $e',
          style: TextStyle(
              color: const Color.fromARGB(255, 153, 2, 2),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      );
    }
  }

//+++++++++++++++++++++++++++++++++++++ coding UI +++++++++++++++++++++++++++++++++++++
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtility.gbScaffold,
        body: SingleChildScrollView(
          child: Stack(children: [
            Align(
              alignment: AlignmentDirectional(0, -0.88),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // +++++++++++++++++++++++++++++++ sign up title ++++++++++++++++++++++++++++++++++
                    Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 90, 8, 0),
                          child: Text('Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 25,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              )),
                        )),
                    //--------------------------------------textfield  fullname------------------------------------------------
                    Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8, 30, 8, 0),
                            child: Container(
                                width: 330,
                                child: Column(children: [
                                  TextFieldsWidget(
                                      controller: _fullnameController,
                                      keyboardType: TextInputType.name,
                                      labelText: 'Full Name ...'),
                                  //---------------------------------------textfield  email-------------------------------------------------
                                  Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 30, 8, 0),
                                        child: Container(
                                            child: TextFieldsWidget(
                                          controller: _emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          labelText: 'Email ...',
                                        )),
                                      )),
                                  //-------------------------------textfield  password --------------------------------------------------------
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 30, 8, 0),
                                      child: Container(
                                        width: 330,
                                        child: TextFieldsWidget(
                                            controller: _passwordController,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            labelText: 'Password'),
                                      ),
                                    ),
                                  ),
                                  //+++++++++++++++++  textfield  confirm password +++++++++++++++++++++++
                                  Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 30, 8, 0),
                                          child: Container(
                                              width: 330,
                                              child: TextFieldsWidget(
                                                controller:
                                                    _confirmpasswordController,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                labelText: 'Confirm Password',
                                              )))),
                                  //++++++++++++++++++++++++++++++  forgot password textbutton ++++++++++++++++++++++++++++++++++++++

                                  Align(
                                      alignment: AlignmentDirectional(1, 0),
                                      child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 15, 30, 0),
                                          child: InkWell(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPasswordPage()),
                                            ),
                                            child: Text('Forgot password?',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  color: Color(0xFFEFC539),
                                                  letterSpacing: 0,
                                                )),
                                          )))
                                ])))),
                    //-----------------------------------sign up button------------------------------------------------
                    Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 16),
                            child: Container(
                              width: 327,
                              height: 52,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                        Color(0xFFEFC539)),
                                  ),
                                  onPressed: () {
                                    signUp();
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ))),

                    //---------------------------------( or sign up with )text---------------------------------------------------------------------------
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
                        child: Text('Or sign up with',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0,
                            )),
                      ),
                    ),
//---------------------------------------facebook button----------------------------------------------------------------
                    Align(
                      alignment: AlignmentDirectional(70, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(35, 0, 0, 0),

                        child: Container(
                          child:
                              Image.asset('assets/images/face and google.PNG'),
                        ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Align(
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Container(
//                             width: 230,
//                             height: 44,
//                             child: ElevatedButton(
//                               style: ButtonStyle(
//                                 backgroundColor:
//                                     WidgetStateProperty.all(Color(0xFF2D62FF)),
//                               ),
//                               onPressed: () {
//                                 print('Button pressed ...');
//                               },
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Icon(
//                                     Icons.facebook,
//                                     color: Colors.white,
//                                     size: 30,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     'Sign in with Facebook',
//                                     style: TextStyle(
//                                       fontFamily: 'Readex Pro',
//                                       color: Colors.white,
//                                       letterSpacing: 0,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
// //-----------------------------------google login---------------------------------------------------
//                         Align(
//                             alignment: AlignmentDirectional(6, 0),
//                             child: Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                               child: Container(
//                                 width: 83,
//                                 height: 44,
//                                 // // child:
//                                 // Image.asset('assets/images/buttons.PNG'),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     null;
//                                   },
//                                   child: FaIcon(
//                                     FontAwesomeIcons.google,
//                                     size: 25,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             )),
//                       ],
//                     ),
                      ),
                    ),
                    //------------------------ already have an account?------------------------------------------
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 5, start: 60),
                      child: Row(
                         mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('You already have an account?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0,
                              )),
                          Align(
                            alignment: AlignmentDirectional(1, 0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 15, 30, 15),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async => await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                ),
                                child: Text('Login Here',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFEFC539),
                                      letterSpacing: 0,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            )
          ]),
        ));
  }
}
