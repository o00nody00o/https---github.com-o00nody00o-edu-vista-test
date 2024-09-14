// ignore_for_file: prefer_const_constructors

import 'package:edu_vista_test/pages/PaymentMethodPage.dart';
import 'package:edu_vista_test/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class PaymentSelectionPage extends StatefulWidget {
  @override
  _PaymentSelectionPageState createState() => _PaymentSelectionPageState();
}

class _PaymentSelectionPageState extends State<PaymentSelectionPage> {
  String _selectedPaymentMethod = 'Card'; // Default selected method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select Your Payment Method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // _buildPaymentOption('PayPal'),
          // _buildPaymentOption('Apple Pay'),
          // _buildPaymentOption('Google Pay'),
          _buildPaymentOption('Paymob'),
        ],
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
        builder: (context) => PaymentMethodPage(),
      ),
    );
  }
}


