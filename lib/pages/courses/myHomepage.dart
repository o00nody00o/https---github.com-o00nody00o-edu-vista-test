// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista_test/pages/account/LoginPage.dart';
import 'package:edu_vista_test/pages/cart/CartPage.dart';
import 'package:edu_vista_test/pages/chat/ChatsPage.dart';
import 'package:edu_vista_test/pages/courses/SearchPage.dart';
import 'package:edu_vista_test/pages/courses/courses.dart';
import 'package:edu_vista_test/pages/profile/ProfilePage.dart';
import 'package:edu_vista_test/widgets/CategoriesFilter.dart';
import 'package:flutter/material.dart';

class myHomepage extends StatefulWidget {
  TextEditingController? email = LoginPageState.emailController; 

  myHomepage({this.email});

  @override
  myHomepageState createState() => myHomepageState();
}

class myHomepageState extends State<myHomepage> {
  static String? fullName;
  int currentIndex = 0;
  BuildContext get context;
  @override
  void initState() {
    super.initState();
    fetchFullName();
  }

  Future<void> fetchFullName() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          fullName = querySnapshot.docs.first.data()['fullName'];
        });
      } else {
        setState(() {
          fullName = "No user found with this email.";
        });
      }
    } catch (e) {
      setState(() {
        fullName = "Error fetching fullName.";
      });
    }
  }

  List<Widget> NavBarBody = [
    SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Welcome',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 23,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  fullName != null
                      ? Text(
                          fullName!,
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF488898),
                            fontSize: 23,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          "UserID9438",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 23,
                          ),
                        ),
               
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Categories',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 19,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      width: 195,
                    ),
                    InkWell(onTap: () => null,
                      child: Text('See All',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ]),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: CategoriesFilter(
                      text: 'Bussiness',
                      containerwidth: 93,
                      containerheight: 38,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: 5),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: CategoriesFilter(
                      text: 'UI/UX',
                      containerwidth: 66,
                      containerheight: 38,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: 5),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: CategoriesFilter(
                      text: 'Software Engineering',
                      containerwidth: 174,
                      containerheight: 38,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ]),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Because You Viewed',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 19,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    width: 115,
                  ),
                  Text('See All',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  mycourse(
                    bigImage: 'assets/images/image 4.png',
                    courseAuther: 'Jack',
                    price: '18.50',
                    courseName: 'Linux for Beginners',
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                    child: mycourse(
                      bigImage: 'assets/images/image 1.png',
                      courseAuther: 'Morgan',
                      courseName: 'Machine Learning',
                      price: '24.50',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Students Also Search for',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 19,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      width: 80,
                    ),
                    Text('See All',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        )),
                  ]),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                          child: mycourse(
                            bigImage: 'assets/images/image3.png',
                            courseAuther: 'Stephen Moris',
                            courseName: 'UI/UX Design',
                            price: '14.50',
                          )),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                        child: mycourse(
                          bigImage: 'assets/images/image 2.png',
                          courseAuther: 'Stephen Moris',
                          courseName: 'Wireframing',
                          price: '18.00',
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Top Courses in IT',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 19,
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(width: 130),
                          Text('See All',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              )),
                        ]),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                        child: mycourse(
                          bigImage: 'assets/images/image3.png',
                          courseAuther: 'Stephen Moris',
                          price: '18.00',
                          courseName: 'Linux for beginners',
                        ),
                      ),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                          child: mycourse(
                            bigImage: 'assets/images/image 2.png',
                            courseAuther: 'Stephen Moris',
                            price: '24.50',
                            courseName: 'Machine Learning',
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),


        
      ),
    )),
    CoursesPage(),
    CartPage(),
    SearchPage(),
    ChatsPage(),
    ProfilePage(currentProfileImageUrl: '',)
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: NavBarBody[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        fixedColor: Colors.amber,
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(backgroundColor: Colors.white,
              label: '',
              icon: Icon(
                Icons.home_filled,
                color: Colors.black,
              )),
          BottomNavigationBarItem(
              label: '', icon: Icon(Icons.book, color: Colors.black)),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
              label: '', icon: Icon(Icons.search, color: Colors.black)),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.chat_bubble_outline, color: Colors.black)),
          BottomNavigationBarItem(
              label: '',
              icon: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipOval(
                      child: Image.asset(
                    'assets/images/nav pic.png',
                    fit: BoxFit.fill,
                  )),
                ),
              ))
        ],
      ),
    );
  }
}
