// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:edu_vista_test/pages/nav%20bar%20tabs/CartPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ChatWindow.dart'; 

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  bool showLatest = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white,
          title: Text('Chats',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                fontSize:  25,
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilterButtonWidget(
                    label: "All",
                    selected: !showLatest,
                    onTap: () {
                      setState(() {
                        showLatest = false;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  FilterButtonWidget(
                    label: "Latest",
                    selected: showLatest,
                    onTap: () {
                      setState(() {
                        showLatest = true;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('chats').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
      
                  var chats = snapshot.data!.docs;
      
                  if (showLatest) {
                    chats.sort((a, b) {
                      return b['timestamp'].compareTo(a['timestamp']);
                    });
                  }
      
                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      var chat = chats[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: SingleChildScrollView(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(chat['profileImage']),
                            ),
                            title: Text(chat['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                            subtitle: Text('You: ${chat['lastMessage']}',style: TextStyle(fontSize: 15,)),
                            trailing: Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)  ,chat['timestamp']
                                .toDate()
                                .toString()
                                .substring(11, 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatWindow(
                                    chatId: chat['id'],
                                    chatName: chat['name'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
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

class FilterButtonWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  FilterButtonWidget(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffF5BB06) : const Color.fromARGB(255, 212, 211, 211),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w100,
            color: selected ? Colors.black : const Color.fromARGB(255, 6, 6, 6),
          ),
        ),
      ),
    );
  }
}
