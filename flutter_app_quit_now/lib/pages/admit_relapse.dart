import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quit_now/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_quit_now/pages/Wishlist.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';
import 'package:flutter_app_quit_now/pages/login.dart';
import 'package:intl/intl.dart';

class AdmitRelapsePage extends StatefulWidget {
  const AdmitRelapsePage({Key? key}) : super(key: key);

  @override
  State<AdmitRelapsePage> createState() => _AdmitRelapsePageState();
}

class _AdmitRelapsePageState extends State<AdmitRelapsePage> {
  var sticks = ' ';
  final User? user = Auth().currentUser;

  final Stream<QuerySnapshot> userDetails =
      FirebaseFirestore.instance.collection('userdetails').snapshots();

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    return FirebaseFirestore.instance
        .collection('userdetails')
        .doc(user?.uid)
        .snapshots();
  }

  Widget _lastRelapseText() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;

            return Text("You last smoked on: ${data['lastRelapse']}",
                style: const TextStyle(fontSize: 18, fontFamily: 'Indies'));
          } else {
            return const Text("Loading",
                style: TextStyle(fontSize: 18, fontFamily: 'Indies'));
          }
        });
  }

  double containerWidth = 450;
  Widget _lastRelapse() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      width: containerWidth,
      decoration: BoxDecoration(
          color: Colors.orange,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/journeystarted.png'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            const SizedBox(height: 10),
            _lastRelapseText()
          ],
        ),
      ),
    );
  }

  Future<void> resetDate() async {
    DateTime now = DateTime.now();
    String todaysDate = DateFormat('MMM dd, yyyy').format(now);
    CollectionReference userDetails =
        FirebaseFirestore.instance.collection('userdetails');
    userDetails.doc(user?.uid).update({'lastRelapse': todaysDate}).catchError(
        (error) => print("Failed to update user: $error"));
  }

  // Widget _admitButton() {
  //   return ElevatedButton(
  //     onPressed: () => Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => const HomePage())),
  //     child: Text("Admit"),
  //   );
  // }
  Widget _admitButton() {
    return ElevatedButton(
      onPressed: () async => {
        if (true)
          {
            resetDate(),
            clearText(),
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Admitted Relapse'),
              ),
            )
          }
      },
      child: const Text("Admit"),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.only(left: 44.0, right: 44.0),
      ),
    );
  }

  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
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
            const SizedBox(height: 10),
            _lastRelapse(),
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
              },
              controller: fieldText,
            ),
            const SizedBox(height: 10),
            _admitButton(),
          ],
        ),
      ),
    );
  }
}
