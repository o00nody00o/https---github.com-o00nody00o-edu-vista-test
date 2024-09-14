// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, library_private_types_in_public_api, use_build_context_synchronously

import 'package:edu_vista_test/engutils/color_utilis.dart';
import 'package:edu_vista_test/pages/categoriesPage.dart';
import 'package:edu_vista_test/pages/forgotPasswordPage.dart';
import 'package:edu_vista_test/pages/loginPage.dart';
import 'package:edu_vista_test/pages/signUpPage.dart';
import 'package:edu_vista_test/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  static TextEditingController emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _login() async {
    try {
      QuerySnapshot userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: emailController.text.trim())
          .where('password', isEqualTo: _passwordController.text.trim())
          .get();

      if (userSnapshot.docs.isEmpty) {
        setState(() {
          _errorMessage = "Account does not exist. Please sign up.";
        });
        return;
      }

      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CategoriesPage()),
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
        title: Text('Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 200),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldsWidget(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'email',
                ),
                SizedBox(height: 20),
                TextFieldsWidget(
                  controller: _passwordController,
                  labelText: 'password',
                  hiddenPassword: true,
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
                SizedBox(height: 100),
                Container(
                  width: 327,
                  height: 52,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                        backgroundColor:
                            WidgetStateProperty.all(Color(0xFFEFC539))),
                    onPressed: _login,
                    child: Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _errorMessage!,
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
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      ),
                      child: Text('Sign Up Here',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFFEFC539),
                            letterSpacing: 0,
                          )),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

