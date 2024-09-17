// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String selectedTab = 'All';
  List<String> filterTabs = [
    'All',
    'Java',
    'C++',
    'C+',
    'Python',
    'Flutter',
    'Machine Learning',
    'UX/UI',
    'Business',
    'Software Engineering'
  ];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> courses = [];

  @override
  void initState() {
    super.initState();
    fetchCourses(); 
  }

  // get courses based on selected filter
  void fetchCourses() async {
    QuerySnapshot snapshot;

    if (selectedTab == 'All') {
      // get all courses
      snapshot = await firestore.collection('course').get();
    } else {
      // get courses where 'courseTitle' matches the selected tab's tilte
      snapshot = await firestore
          .collection('course')
          .where('courseTitle', isGreaterThanOrEqualTo: selectedTab)
          .where('courseTitle', isLessThanOrEqualTo: selectedTab + '\uf8ff')
          .where('courseTitle', isEqualTo: selectedTab)
          .get();
    }

    // Convert documents to a list of maps
    setState(() {
      courses = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Center(
          child: Text('Courses',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                fontSize: 25,
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filterTabs.map((tab) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = tab;
                      fetchCourses(); 
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: selectedTab == tab
                          ? const Color(0xFFEFC539)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tab,
                      style: TextStyle(
                        fontSize: selectedTab == tab ? 25 : 15,
                        color: selectedTab == tab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          // Courses widget
          Expanded(
            child: courses.isEmpty
                ? Center(
                    child: Text('No courses found related to this Category'))
                : ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      var course = courses[index];
                      return SingleChildScrollView(
                        child: InkWell(
                          onTap: () => null,
                          child: ListTile(
                            style: ListTileStyle.drawer,
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
                                style: TextStyle(
                                  fontSize: 18,
                                )),
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
    );
  }
}
