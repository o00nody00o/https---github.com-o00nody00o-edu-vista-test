// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista_test/pages/LoginPage.dart';
import 'package:edu_vista_test/pages/forgotPasswordPage.dart';
import 'package:edu_vista_test/widgets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPasswordPage extends StatefulWidget {
    TextEditingController?  email = ForgotPasswordPageState.emailController ;
  ResetPasswordPage({super .key,  this.email});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;

  Future<void> _resetPassword() async {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      Fluttertoast.showToast(
          msg: "Both passwords are not the same.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      
      await _firestore
          .collection('users')
          .where('email', isEqualTo: widget.email)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.first.reference.update({'password': password});
        }
      });

      
      Fluttertoast.showToast(
          msg: "Password reset successfully.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);

      Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage())); 
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to reset password. Try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Reset Password',
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

                        TextFieldsWidget(labelText: 'New Password', controller: _passwordController,hiddenPassword: true,),

            // TextField(
            //   controller: _passwordController,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     labelText: 'New Password',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            SizedBox(height: 20),


            TextFieldsWidget(labelText: 'Confirm Password', controller:  _confirmPasswordController,hiddenPassword: true,),
            // TextField(
            //   controller: _confirmPasswordController,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     labelText: 'Confirm Password',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Container( width: 327,
                  height: 52,
                  child: ElevatedButton(
                        style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xFFEFC539))),
                        onPressed:  _resetPassword,
                        child: Text('Submit',style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                ),
                //  ElevatedButton(
                //     onPressed: _resetPassword,
                //     child: Text("Reset Password"),
                //   ),
          ],
        ),
      ),
    );
  }
}
