// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AboutUsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Text(
          'About Edu Vista',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome to Edu Vista!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 1, 119, 161)),
            ),
            SizedBox(height: 10),
            Text(
              'Edu Vista is your ultimate destination for online education and skill development. We offer a wide range of high-quality courses in fields like programming, design, business, and more. Whether you’re a beginner or looking to advance your career, Edu Vista is here to help you learn, grow, and achieve your goals.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Our courses are designed by industry experts to give you the skills and knowledge to succeed in the real world. Join us at Edu Vista and unlock your full potential today!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 249, 191, 1), // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Closes the dialog
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Close', style: TextStyle(fontSize: 20,color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
