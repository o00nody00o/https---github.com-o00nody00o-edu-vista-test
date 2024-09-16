// // ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:edu_vista_test/pages/nav%20bar%20tabs/PaymentcardPage.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/ChoosePaymentPage.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> selectedCourses;
  final double totalPrice;

  CheckoutPage({required this.selectedCourses, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white ,
      appBar: AppBar( backgroundColor: Colors.white, title: Center(
        child: Text('Checkout', style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                )),
      ),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: selectedCourses.length,
                itemBuilder: (context, index) {
                  var course = selectedCourses[index];
                  return SingleChildScrollView(
                    child: ListTile(
                      leading: Container(
                          height: 110,
                          width: 90,
                          child: Image.network(
                            course['imageUrl'],
                            fit: BoxFit.fill,
                          )),
                      title: Text(
                        course['courseTitle'],
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                          ' ${course['teacher']}',
                          style: TextStyle(fontSize:16 ,fontWeight: FontWeight.w300)),trailing: Text(' \$${course['price']}', style: TextStyle(
                                    color: const Color(0xff477B72),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ),
            // Total Price
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Submit Button
            Container(
              width: 327,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChoosePaymentPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFC539),
                ),
                child: Text('Submit',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
