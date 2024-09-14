// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista_test/utils/color_utilis.dart';
import 'package:edu_vista_test/pages/LoginPage.dart';
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

  Future<bool> checkIfEmailExists( String email) async {
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
        Fluttertoast.showToast(
            msg: "Password reset email has been sent.",
            toastLength: Toast.LENGTH_LONG);
            Navigator.push(context,MaterialPageRoute(
                          builder: (context) => LoginPage()));
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Failed to send reset email. Please try again.",
            toastLength: Toast.LENGTH_LONG);
      }
    } else {
      Fluttertoast.showToast(
          msg: "The email entered does not exist. Please sign up.",
          toastLength: Toast.LENGTH_LONG);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Forgot Password',
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
           TextFieldsWidget(labelText: 'Enter your email', controller: emailController,),

           
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                :
                Container( width: 327,
                  height: 52,
                  child: Container( width: 327,
                  height: 52,
                    child: ElevatedButton(
                        style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xFFEFC539))),
                        onPressed: sendPasswordResetEmail,
                        child: Text('Submit',style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                  ),
                ),
                
               
          ],
        ),
      ),
    );
  }
}



































// class ForgotPasswordPage extends StatefulWidget {
//   @override
//   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Text(
//                     'Reset Password',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 250),
//                 //++++++++++++++++++++++++++++++++++++++++++++++++ textfield +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 1),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Email',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       TextFormField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           hintText: 'demo@mail.com',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 14,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
//                               .hasMatch(value)) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 150),
//                 //+++++++++++++++++++++++++++++++++++++++++++++ button +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//                 Center(
//                   child: SizedBox(
//                     height: 60,
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _isLoading ? null : _resetPassword,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: ColorUtility.deepYellow,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                       ),
//                       child: _isLoading
//                           ? CircularProgressIndicator(
//                               color: Colors.white,
//                             )
//                           : Text(
//                               'SUBMIT',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   letterSpacing: 1),
//                             ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _resetPassword() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         // Check if the email exists in Firestore
//         var userSnapshot = await FirebaseFirestore.instance
//             .collection('data') // Your collection name
//             .where('email', isEqualTo: _emailController.text.trim())
//             .get();

//         if (userSnapshot.docs.isEmpty) {
//           // Email does not exist in Firestore
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Email does not exist.')),
//           );
//         } else {
//           // Email exists, proceed to send password reset email
//           await FirebaseAuth.instance
//               .sendPasswordResetEmail(email: _emailController.text.trim());
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Password reset email sent!')),
//           );
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
//           );
//         }
//       } on FirebaseAuthException catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${e.message}')),
//         );
//       } catch (e) {
//         // Catch any other errors
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('An error occurred: $e')),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
// }
