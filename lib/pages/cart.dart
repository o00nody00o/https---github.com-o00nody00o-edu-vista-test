// ignore_for_file: sort_child_properties_last, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:edu_vista_test/pages/checkoutPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> selectedCourses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('course').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var courses = snapshot.data!.docs;

          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              var course = courses[index].data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: Image.network(course['imageUrl']),
                  title: Text(course['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Instructor: ${course['instructor']}'),
                      Text('Price: \$${course['price']}'),
                      SizedBox(height: 8),
                      DropdownButton<String>(
                        hint: Text('Select Action'),
                        items: [
                          DropdownMenuItem(
                            child: Text('Buy Now'),
                            value: 'buy',
                          ),
                          DropdownMenuItem(
                            child: Text('Cancel'),
                            value: 'cancel',
                          ),
                        ],
                        onChanged: (value) {
                          if (value == 'buy') {
                            setState(() {
                              selectedCourses.add(course);
                            });
                          }
                          //  Cancel 
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: selectedCourses.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
               
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(courses: selectedCourses),
                  ),
                );
              },
              child: Icon(Icons.shopping_cart_checkout),
            )
          : Container(),
    );
  }
}
