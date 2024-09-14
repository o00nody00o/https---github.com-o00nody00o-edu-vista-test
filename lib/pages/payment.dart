// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:paymob_payment/paymob_payment.dart'; // Example, update if needed



class PaymentMethodPage extends StatefulWidget {
    static const String id = 'PaymentMethodPage';

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Replace with your Paymob credentials
  final String apiKey = '';
  final String integrationId = '';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: _cardNumberController,
              label: 'Card Number',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _expiryDateController,
                    label: 'Exp. Date',
                    hintText: 'MM/YYYY',
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _cvvController,
                    label: 'CVV',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 24),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.yellow,
            //     padding: EdgeInsets.symmetric(vertical: 16),
            //     minimumSize: Size(double.infinity, 50),
            //   ),
            //   onPressed: 
            //   _processPayment,
            //   child: Text(
            //     'CONTINUE',
            //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  // Future<void> _processPayment() async {
  //   if (_cardNumberController.text.isEmpty ||
  //       _expiryDateController.text.isEmpty ||
  //       _cvvController.text.isEmpty ||
  //       _phoneController.text.isEmpty) {
  //     _showMessage('Please fill in all fields.');
  //     return;
  //   }

  //   try {
  //     // Initialize Paymob SDK
  //     PaymobPayment paymobPayment = PaymobPayment(apiKey: apiKey);

  //     // Register order on Paymob
  //     final order = await paymobPayment.createOrder(
  //       amountCents: 1000, // Example amount in cents
  //       currency: 'EGP',
  //       merchantOrderId: 'order_${DateTime.now().millisecondsSinceEpoch}',
  //     );

  //     // Create a payment key
  //     final paymentKey = await paymobPayment.createPaymentKey(
  //       orderId: order.id,
  //       amountCents: 1000,
  //       currency: 'EGP',
  //       integrationId: integrationId,
  //       billingData: {
  //         'first_name': 'John',
  //         'last_name': 'Doe',
  //         'phone_number': _phoneController.text,
  //         'email': EmailAuthCredential,
  //         'country': 'EG',
  //       },
  //     );

  //     // Perform the payment using card details
  //     final paymentResult = await paymobPayment.payWithCard(
  //       paymentKey: paymentKey.token,
  //       cardNumber: _cardNumberController.text,
  //       cardExpiry: _expiryDateController.text, // Should be in format MM/YYYY
  //       cardCvv: _cvvController.text,
  //     );

  //     if (paymentResult.success) {
  //       _showMessage('Payment Successful!');
  //       _savePaymentDetails(paymentResult.transactionId);
  //     } else {
  //       _showMessage('Payment Failed: ${paymentResult.errorMessage}');
  //     }
  //   } catch (e) {
  //     _showMessage('Error occurred: $e');
  //   }
  // }

//   Future<void> _savePaymentDetails(String transactionId) async {
//     try {
//       await _firestore.collection('payments').add({
//         'transactionId': transactionId,
//         'amount': 10.0, // Example amount, replace with actual
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//       _showMessage('Payment details saved successfully.');
//     } catch (e) {
//       _showMessage('Failed to save payment details: $e');
//     }
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
}
