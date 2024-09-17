// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_null_comparison, must_be_immutable

import 'package:edu_vista_test/pages/profile/aboutus.dart';
import 'package:edu_vista_test/pages/account/LoginPage.dart';
import 'package:edu_vista_test/pages/cart/CartPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  TextEditingController? email = LoginPageState.emailController;

  String currentProfileImageUrl =
      'https://static.vecteezy.com/system/resources/previews/024/183/535/non_2x/male-avatar-portrait-of-a-young-man-with-glasses-illustration-of-male-character-in-modern-color-style-vector.jpg'; // Current profile image URL
  ProfilePage({required this.currentProfileImageUrl, this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? fullName;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';

  late String selectedProfileImage; // Selected profile image

  @override
  void initState() {
    super.initState();
    fetchFullName();

    selectedProfileImage = widget.currentProfileImageUrl;
  }

  // Fetch images from Firestore collection 'image'
  Future<List<String>> fetchImagesFromFirestore() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('image').get();
    return snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
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
          email = querySnapshot.docs.first.data()['email'];
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

  void showImageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: FutureBuilder<List<String>>(
            future: fetchImagesFromFirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No images available.'));
              }

              List<String> images = snapshot.data!;

              return Container(
                padding: EdgeInsets.all(10),
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedProfileImage = images[index];
                              });
                              Navigator.pop(
                                  context); // Close dialog after selection
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(images[index]),
                                radius: 40,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showImageSelectionDialog(context); // Open dialog on tap
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(selectedProfileImage),
                        radius: 50,
                      ),
                      SizedBox(
                        width: 90,
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              fullName != null
                  ? Center(
                      child: Text(
                        fullName!,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    )
                  : Center(
                      child: Text(
                        "userID:109787665",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

              email != null
                  ? Center(
                      child: Text(
                        email!,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 30, 255)),
                      ),
                    )
                  : Center(
                      child: Text(
                        "couldn't get email",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
              // Text(
              //   _fullName,
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              // Text(_email, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 20),
              _buildProfileOption('Edit', Icons.arrow_forward_ios, () {}),
              _buildProfileOption('Setting', Icons.arrow_forward_ios, () {}),

              _buildProfileOption('About Us', Icons.arrow_forward_ios, () {
                showDialog(
  context: context,
  builder: (BuildContext context) {
    return AboutUsDialog();
  },
);
              }),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextButton(
                  onPressed: _logout,
                  child: Text('Logout',
                      style: TextStyle(color: Colors.red, fontSize: 25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: Icon(icon),
      onTap: onTap,
    );
  }
}
