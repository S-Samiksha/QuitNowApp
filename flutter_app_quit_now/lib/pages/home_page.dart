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

  Widget _welcomeBackText() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;

            return Text("Welcome back ${data['name']}!",
                style: const TextStyle(
                    fontSize: 25,
                    fontFamily: 'Indies',
                    fontWeight: FontWeight.bold));
          } else {
            return const Text("Welcome back!",
                style: TextStyle(fontSize: 25, fontFamily: 'Indies'));
          }
        });
  }

  Widget _journeyStartedText() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;

            return Text("Your journey started on: ${data['quitDate']}",
                style: const TextStyle(fontSize: 18, fontFamily: 'Indies'));
          } else {
            return const Text("Loading",
                style: TextStyle(fontSize: 18, fontFamily: 'Indies'));
          }
        });
  }

  Widget _daysSinceCommitmentText() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            // do calculation here

            return const Text("25",
                style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Indies',
                    fontWeight: FontWeight.bold));
          } else {
            return const Text("Loading",
                style: TextStyle(fontSize: 18, fontFamily: 'Indies'));
          }
        });
  }

  Widget _currentStreakText() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            // do calculation here
            int test = 2;
            return Text("Current streak: ${test} Days",
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Indies',
                ));
          } else {
            return const Text("Loading",
                style: TextStyle(fontSize: 18, fontFamily: 'Indies'));
          }
        });
  }

  double containerWidth = 500;

  Widget _journeyStarted() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 160,
      width: containerWidth,
      decoration: BoxDecoration(
          color: Color.fromARGB(241, 250, 250, 250),
          border: Border.all(
            color: Color.fromARGB(241, 250, 250, 250),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  // TODO: help none of my images appear
                  image: AssetImage('assets/images/quitsmoking.png'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 10),
            _journeyStartedText()
          ],
        ),
      ),
    );
  }

  Widget _daysSinceCommitment() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 110,
      width: containerWidth,
      decoration: BoxDecoration(
          color: Color.fromARGB(241, 250, 250, 250),
          border: Border.all(
            color: Color.fromARGB(241, 250, 250, 250),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _daysSinceCommitmentText(),
            const Text("Total number of days since commitment",
                style: TextStyle(fontSize: 18, fontFamily: 'Indies'))
          ],
        ),
      ),
    );
  }

  Widget _currentStreak() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 160,
      width: containerWidth,
      decoration: BoxDecoration(
          color: Color.fromARGB(241, 250, 250, 250),
          border: Border.all(
            color: Color.fromARGB(241, 250, 250, 250),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  // TODO: help none of my images appear
                  image: AssetImage('assets/images/quitsmoking.png'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 10),
            _currentStreakText()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Colors.orange[300],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _welcomeBackText(),
            const SizedBox(height: 10),
            _journeyStarted(),
            const SizedBox(height: 10),
            _daysSinceCommitment(),
            const SizedBox(height: 10),
            _currentStreak(),
            const SizedBox(height: 10),
            _signOutButton()
          ],
        ),
      ),
    ));
  }
}

// old code
class _HomePageStateTwo extends State<HomePage> {
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
            return Text("Loading...");
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
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdmitRelapsePage())),
      child: Text("Admit Relapse"),
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
            const SizedBox(height: 10),
            _admitRelapseButton(),
            const SizedBox(height: 20),
            _wishlistButton(),
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
            icon: Icon(Icons.emergency),
            label: 'Admit Relapse',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
