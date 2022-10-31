import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quit_now/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_quit_now/pages/Wishlist.dart';
import 'package:flutter_app_quit_now/pages/admit_relapse.dart';
import 'package:flutter_app_quit_now/pages/login.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_share/social_share.dart';

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
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () async => {
                  if (await signOut())
                    {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => const LoginPage()))
                      // Navigator.of(context).popUntil((route) => route.isFirst)
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginPage()))
                    }
                },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            child:
                const Text('Sign Out', style: TextStyle(color: Colors.white))));
  }

  String quitDateSM = "";
  String commitmentSM = "";
  String streakSM = "";

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

            quitDateSM = data['quitDate'];
            return Text("Your journey started on: ${data['quitDate']}",
                style: const TextStyle(fontSize: 18, fontFamily: 'Indies'));
          } else {
            return const Text("Loading",
                style: TextStyle(fontSize: 18, fontFamily: 'Indies'));
          }
        });
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).ceil();
  }

  Widget _daysSinceCommitmentText() {
    return StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            // do calculation here
            String quitDate = data['quitDate'];
            var formatter = DateFormat('MMM dd, yyyy');
            var formattedDate = formatter.parse(quitDate);
            final todaysDate = DateTime.now();
            final difference = daysBetween(formattedDate, todaysDate);

            commitmentSM = difference.toString();

            return Text(difference.toString(),
                style: const TextStyle(
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
            String quitDate = data['lastRelapse'];
            var formatter = DateFormat('MMM dd, yyyy');
            var formattedDate = formatter.parse(quitDate);
            final todaysDate = DateTime.now();
            final difference = daysBetween(formattedDate, todaysDate);

            streakSM = difference.toString();

            return Text("Current streak: $difference Day(s)",
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
      height: 180,
      width: containerWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 120.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/journeystarted.png'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            const SizedBox(height: 15),
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
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _daysSinceCommitmentText(),
            const Text("Total days since commitment",
                style: TextStyle(fontSize: 18, fontFamily: 'Indies'))
          ],
        ),
      ),
    );
  }

  Widget _currentStreak() {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 150,
      width: containerWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _welcomeBackText(),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.squareTwitter, size: 35),
                  color: Color(0xFF0080fc),
                  tooltip: 'Share on Twitter',
                  onPressed: () async {
                    SocialShare.shareTwitter(
                      "Started to quit smoking on ${quitDateSM}, it has been ${commitmentSM} days and my current streak is ${streakSM} days ",
                      hashtags: ["stop", "smoking", "streak"],
                    ).then((data) {
                      print(data);
                    });
                  },
                ),
              ],
            ),
            // const SizedBox(height: 10),
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
