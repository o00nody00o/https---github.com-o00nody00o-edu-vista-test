// ignore_for_file: prefer_const_constructors

import 'package:edu_vista_test/pages/nav%20bar%20tabs/PaymentcardPage.dart';
import 'package:edu_vista_test/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class ChoosePaymentPage extends StatefulWidget {
  @override
  _ChoosePaymentPageState createState() => _ChoosePaymentPageState();
}

class _ChoosePaymentPageState extends State<ChoosePaymentPage> {
  String _selectedPaymentMethod = 'Card'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method',  style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Your Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
           
            _buildPaymentOption('Paymob'),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String method) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: _selectedPaymentMethod == method ? Colors.yellow.shade50 : Colors.grey.shade200,
        child: RadioListTile(
          activeColor: ColorUtility.deepYellow,
          value: method,
          groupValue: _selectedPaymentMethod,
          title: Text(
            method,
            style: TextStyle(
              color: _selectedPaymentMethod == method ? ColorUtility.deepYellow : Colors.black,
              fontWeight: _selectedPaymentMethod == method ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
              if (_selectedPaymentMethod == 'Paymob') {
                _navigateToPaymentMethodPage();
              }
            });
          },
        ),
      ),
    );
  }

  void _navigateToPaymentMethodPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentcardPage(),
      ),
    );
  }
}


