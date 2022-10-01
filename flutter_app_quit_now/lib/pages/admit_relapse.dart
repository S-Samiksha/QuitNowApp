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

  Widget _admitButton() {
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage())),
      child: Text("Admit"),
    );
  }

  Widget _wishlistButton() {
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => WishlistPage())),
      child: Text("Wishlist"),
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
    );
  }
}
