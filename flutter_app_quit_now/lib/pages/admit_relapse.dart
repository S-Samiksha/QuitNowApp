//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quit_now/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_quit_now/pages/Wishlist.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';
import 'package:flutter_app_quit_now/pages/login.dart';

class AdmitRelapsePage extends StatefulWidget {
  const AdmitRelapsePage({Key? key}) : super(key: key);

  @override
  State<AdmitRelapsePage> createState() => _AdmitRelapsePageState();
}

class _AdmitRelapsePageState extends State<AdmitRelapsePage> {
  var sticks = ' ';
  // List sticks1 = ["1", "2", "3", "4", "5"];
  //String selectedItem;
  final User? user = Auth().currentUser;

  final Stream<QuerySnapshot> userDetails =
      FirebaseFirestore.instance.collection('userdetails').snapshots();

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    return FirebaseFirestore.instance
        .collection('userdetails')
        .doc(user?.uid)
        .snapshots();
  }

//calculate current streak
//still need to work on parsing the string date into the required format
  Widget _streak() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            final date = DateTime(2022, 09,
                01); //date stores the quit date --> hard code to 1oct first
            final currentDate = DateTime.now();
            final difference = currentDate.difference(date).inDays;
            return Text("streak: ${difference}");

            //return Text("Quit Date: ${data['quitDate']}");
          } else {
            return Text("Loading...");
          }
        });
  }

  Widget _title() {
    return const Text('Admit Relapse');
  }

  Widget _admitButton() {
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage())),
      child: const Text("Admit"),
    );
  }

  // Widget _admitButton() {
  //   width:
  //   300;
  //   return ElevatedButton(
  //     onPressed: () async => {
  //       if (await resetStreak())
  //         {
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (context) => const HomePage()))
  //         }
  //     },
  //     child: const Text("Admit"),
  //     style: ElevatedButton.styleFrom(
  //       padding: const EdgeInsets.only(left: 44.0, right: 44.0),
  //     ),
  //   );
  // }

  Widget _wishlistButton() {
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => WishlistPage())),
      child: const Text("Wishlist"),
    );
  }

  //for bottom navigation bar
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.format_list_numbered),
                  labelText: 'Input Number of sticks smoked today:',
                ),
                onChanged: (value) {
                  sticks = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some number";
                  }
                  return null;
                }),
            _streak(),
            const SizedBox(height: 10),
            _admitButton(),
            const SizedBox(height: 20),
            _wishlistButton(),
            // Center(
            //   child: ElevatedButton(
            //     onPressed:(){
            //       if
            //     }

            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 248, 204, 137),
        elevation: 8,
        iconSize: 20,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task_rounded),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home Page',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
//why doesn't this work :(
// class AdmitForm extends StatefulWidget {
//   const AdmitForm({super.key});

//   @override
//   State<AdmitForm> createState() => _AdmitFormState();
// }

// class _AdmitFormState extends State<AdmitForm> {
//   final _formKey = GlobalKey<FormState>();
//   var sticks = ' ';

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _formKey,
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//                 decoration: const InputDecoration(
//                   icon: Icon(Icons.format_list_numbered),
//                   labelText: 'Input Number of sticks smoked today:',
//                 ),
//                 onChanged: (value) {
//                   sticks = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter some number";
//                   }
//                   return null;
//                 }),
//           ],
//         ));
//   }
// }
