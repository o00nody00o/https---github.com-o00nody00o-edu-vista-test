// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:edu_vista_test/pages/PaymentMethodPage.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> courses;

  CheckoutPage({required this.courses});

  @override
  Widget build(BuildContext context) {
    double totalPrice = courses.fold(0, (sum, course) => sum + course['price']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                var course = courses[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(course['imageUrl']),
                    title: Text(course['title']),
                    subtitle: Text('Instructor: ${course['instructor']}'),
                    trailing: Text('\$${course['price']}'),
                  ),
                );
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Total: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethodPage(),
                  ),
                );
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
