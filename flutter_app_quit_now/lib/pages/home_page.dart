import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quit_now/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_quit_now/pages/Wishlist.dart';
import 'package:flutter_app_quit_now/pages/admit_relapse.dart';
import 'package:flutter_app_quit_now/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;

  final Stream<QuerySnapshot> userDetails =
      FirebaseFirestore.instance.collection('userdetails').snapshots();

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    return FirebaseFirestore.instance
        .collection('userdetails')
        .doc(user?.uid)
        .snapshots();
  }

  Future<bool> signOut() async {
    try {
      await Auth().signOut();
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      print(e);
      return Future.value(false);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
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
            return const Text("Welcome");
          }
        });
  }

  Widget _userUid() {
    // print(user);
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: () async => {
        if (await signOut())
          {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const LoginPage()))
            // Navigator.of(context).popUntil((route) => route.isFirst)
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage()))
          }
      },
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
            return const Text("Loading...");
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
            return const Text("Loading...");
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
            return const Text("Loading...");
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
            return const Text("Loading...");
          }
        });
  }

  Widget _admitRelapseButton() {
    //do this now!!
    return ElevatedButton(
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AdmitRelapsePage())),
      child: const Text("Admit Relapse"),
    );
  }

  Widget _wishlistButton() {
    return ElevatedButton(
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WishlistPage())),
      child: const Text("Wishlist"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(height: 10),
            _admitRelapseButton(),
            const SizedBox(height: 20),
            _wishlistButton(),
          ],
        ),
      ),
    );
  }
}
