import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_quit_now/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  final Stream<QuerySnapshot> userDetails =
      FirebaseFirestore.instance.collection('userdetails').snapshots();

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    return FirebaseFirestore.instance
        .collection('userdetails')
        .doc(user?.uid)
        .snapshots();
  }

  Future<void> signOut() async {
    await Auth().signOut();
    // Navigator.popUntil(context, ModalRoute.withName("/"));
  }

  Widget _title() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;

            return Text("Welcome ${data['name']}");
          } else {
            return Text("Welcome");
          }
        });
  }

  Widget _userUid() {
    // print(user);
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  Widget _quitDate() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;

            return Text("Quit Date: ${data['quitDate']}");
          } else {
            return Text("Error Fetching Quit Date");
          }
        });
  }

  Widget _sticksPerDay() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;

            return Text("Sticks per Day: ${data['sticksPerDay']}");
          } else {
            return Text("Error Fetching sticksPerDay");
          }
        });
  }

  Widget _sticksPerPack() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;

            return Text("Sticks per Pack: ${data['sticksPerPack']}");
          } else {
            return Text("Error Fetching sticksPerPack");
          }
        });
  }

  Widget _costPerPack() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;

            return Text("Cost Per Pack: ${data['costPerPack']}");
          } else {
            return Text("Error Fetching costPerPack");
          }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            _quitDate(),
            _sticksPerDay(),
            _costPerPack(),
            _sticksPerPack(),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
