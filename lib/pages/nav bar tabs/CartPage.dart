// ignore_for_file: sized_box_for_whitespace, deprecated_member_use, prefer_const_constructors

import 'package:edu_vista_test/pages/nav%20bar%20tabs/checkoutPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> courses = []; // Store course data
  List<Map<String, dynamic>> selectedCourses = []; // Store selected courses
  double totalPrice = 0.0; // Store the total price

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  // Fetch courses from Firestore 'course' collection
  Future<void> fetchCourses() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('course').get();
    setState(() {
      courses = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // Update selected courses and total price
  void toggleCourseSelection(bool isChecked, Map<String, dynamic> course) {
    setState(() {
      if (isChecked) {
        selectedCourses.add(course);
        totalPrice += course['price'];
      } else {
        selectedCourses.remove(course);
        totalPrice -= course['price'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white ,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text('Cart',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                fontSize: 25,
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  var course = courses[index];
                  return SingleChildScrollView(
                    child: InkWell(
                      onTap: () => null,
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
                          style: TextStyle(fontSize: 18,  fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                            ' ${course['teacher']}\n \$${course['price']}',
                            style: TextStyle(fontSize:16 , fontWeight: FontWeight.w100)),
                        trailing: MSHCheckbox(
                          size: 25,
                          value: selectedCourses.contains(course),
                          checkedColor: Color(0xFFEFC539),
                          style: MSHCheckboxStyle.stroke,
                          onChanged: (value) {
                            toggleCourseSelection(value, course);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Checkout Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 327,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                            selectedCourses: selectedCourses,
                            totalPrice: totalPrice),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEFC539),
                  ),
                  child: Text('Check Out',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
