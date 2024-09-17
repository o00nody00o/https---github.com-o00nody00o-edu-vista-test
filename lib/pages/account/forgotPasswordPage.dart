// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista_test/pages/account/resetpassword.dart';
import 'package:edu_vista_test/pages/account/LoginPage.dart';
import 'package:edu_vista_test/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  static TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;

  Future<bool> checkIfEmailExists(String email) async {
    final userSnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    return userSnapshot.docs.isNotEmpty;
  }

  Future<void> sendPasswordResetEmail() async {
    setState(() {
      _isLoading = true;
    });

    String email = emailController.text.trim();

    bool emailExists = await checkIfEmailExists(email);

    if (emailExists) {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 137, 237, 110),
            content: Center(
              child: Text(
                'email has been sent',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            )));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 242, 146, 148),
            content: Center(
              child: Text(
                'Failed to send reset email',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            )));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor:  Color.fromARGB(255, 242, 146, 148),
            content: Center(
              child: Text(
                'The email is not exist',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            )));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldsWidget(
              labelText: 'Enter your email',
              controller: emailController,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : SizedBox(
                   width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          backgroundColor:
                              WidgetStateProperty.all(Color(0xFFEFC539))),
                      onPressed: sendPasswordResetEmail,
                      child: Text('Submit',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
