// ignore_for_file: prefer_const_constructors

import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';
  List<QueryDocumentSnapshot> searchResults = [];

  Future<void> performSearch(String searchText) async {
    // search in Firestore for something similar to what the user entered
    final courses = await FirebaseFirestore.instance
        .collection('course')
        .where('courseTitle', isGreaterThanOrEqualTo: searchText)
        .where('courseTitle', isLessThanOrEqualTo: searchText + '\uf8ff')
        .get();

    final priceResults = await FirebaseFirestore.instance
        .collection('course')
        .where('price', isEqualTo: double.tryParse(searchText))
        .get();

    final teacherResults = await FirebaseFirestore.instance
        .collection('course')
        .where('teacher', isGreaterThanOrEqualTo: searchText)
        .where('teacher', isLessThanOrEqualTo: searchText + '\uf8ff')
        .get();

    setState(() {
      searchResults = courses.docs + priceResults.docs + teacherResults.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text('Search Courses',
            style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by course title, teacher, or price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
            SizedBox(height: 25),

            // Search Button
            Container( width: 327,
                  height: 52,
              child: ElevatedButton(
                onPressed: () {
                  performSearch(searchText);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFC539),
                ),
                child: Text('Search', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),

            SizedBox(height: 16.0),

            // show the result as widget
            searchResults.isEmpty
                ? Padding(
                    padding: EdgeInsets.fromLTRB(0,200, 0, 0),
                    child: Text('No results found',style: TextStyle(fontSize: 20),),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        var course = searchResults[index];

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
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text('${course['teacher']}',
                                  style: TextStyle(fontSize: 18, )),

                              trailing: Text(
                                '\$${course['price'].toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: const Color(0xff477B72),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
