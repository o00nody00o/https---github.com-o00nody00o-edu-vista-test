// ignore_for_file: prefer_const_constructors, use_build_context_synchronously


import 'package:edu_vista_test/pages/account/LoginPage.dart';
import 'package:edu_vista_test/pages/nav%20bar%20tabs/CartPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  String? _profileImageUrl;
  String _fullName = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      var userDoc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _fullName = userDoc['fullName'] ?? 'unable to get the name';
        _email = userDoc['email'] ?? 'unable to get the name';
        _profileImageUrl = userDoc['profileImageUrl'];
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      await _uploadImage(file);
    }
  }

  Future<void> _uploadImage(File file) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref('profileImages/${user.uid}')
            .putFile(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();

        await _firestore.collection('users').doc(user.uid).update({
          'profileImageUrl': downloadUrl,
        });

        setState(() {
          _profileImageUrl = downloadUrl;
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
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
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
 Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage()), 
    );            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _profileImageUrl != null
                  ? NetworkImage(_profileImageUrl!)
                  : AssetImage('assets/placeholder.png') as ImageProvider,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.camera_alt, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            _fullName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(_email, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 20),
          _buildProfileOption('Edit', Icons.arrow_forward_ios, () {
          }),
          _buildProfileOption('Setting', Icons.arrow_forward_ios, () {
          }),
         
          _buildProfileOption('About Us', Icons.arrow_forward_ios, () {
          }),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextButton(
              onPressed: _logout,
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
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

