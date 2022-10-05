import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quit_now/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_quit_now/pages/addItem.dart';
import 'package:flutter_app_quit_now/pages/admit_relapse.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';
import 'package:flutter_app_quit_now/pages/login.dart';
import 'package:intl/intl.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final User? user = Auth().currentUser;

  Stream<DocumentSnapshot> userDetailsDocumentFieldStream() {
    return FirebaseFirestore.instance
        .collection('userdetails')
        .doc(user?.uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> wishlistDocumentFieldStream() {
    return FirebaseFirestore.instance
        .collection('wishlist')
        .where('uid', isEqualTo: user?.uid)
        .orderBy('createdAt', descending: false)
        .snapshots();
  }

  double totalSavings = 0;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  late final StreamSubscription userDetails;
  @override
  void initState() {
    // TODO: implement initState
    userDetails = FirebaseFirestore.instance
        .collection('userdetails')
        .doc(user?.uid)
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.data();
      // formula: (diff/(SPP/SPD)) * CPP
      String quitDate = data?['quitDate'];
      double costPerPack = data?['costPerPack'].toDouble();
      double sticksPerDay = data?['sticksPerDay'].toDouble();
      var sticksPerPack = data?['sticksPerPack'].toDouble();
      var formatter = DateFormat('MMM dd, yyyy');
      var formattedDate = formatter.parse(quitDate);
      final todaysDate = DateTime.now();
      int difference = daysBetween(formattedDate, todaysDate);
      double savings =
          (difference.toDouble() / (sticksPerPack / sticksPerDay)) *
              costPerPack;
      totalSavings = savings;
    });
    super.initState();
  }

  Widget totalSavingsText() {
    return StreamBuilder<DocumentSnapshot>(
        stream: userDetailsDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;

            // formula: (diff/(SPP/SPD)) * CPP
            String quitDate = data['quitDate'];
            double costPerPack = data['costPerPack'].toDouble();
            double sticksPerDay = data['sticksPerDay'].toDouble();
            var sticksPerPack = data['sticksPerPack'].toDouble();
            var formatter = DateFormat('MMM dd, yyyy');
            var formattedDate = formatter.parse(quitDate);
            final todaysDate = DateTime.now();
            int difference = daysBetween(formattedDate, todaysDate);
            double savings =
                (difference.toDouble() / (sticksPerPack / sticksPerDay)) *
                    costPerPack;
            totalSavings = savings;

            return Text("Total savings: \$${savings.toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Indies',
                    fontWeight: FontWeight.bold));
          } else {
            return const Text("Loading",
                style: TextStyle(fontSize: 18, fontFamily: 'Indies'));
          }
        });
  }

  String itemName = "";
  String itemPrice = "";

  Future<void> createWishlistItem() async {
    CollectionReference wishlistCollection =
        FirebaseFirestore.instance.collection('wishlist');
    wishlistCollection.add({
      'itemName': itemName,
      'itemPrice': itemPrice,
      'uid': user?.uid,
      'createdAt': DateTime.now()
    });
  }

  Future<void> deleteWishlistItem(String docId) async {
    CollectionReference wishlistCollection =
        FirebaseFirestore.instance.collection('wishlist');
    wishlistCollection
        .doc(docId)
        .delete()
        .then((_) => print("Deleted item $docId"))
        .catchError((error) => print('Delete failed for $docId: $error'));
  }

  Widget addItemButton() {
    final _formKey = GlobalKey<FormState>();

    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: const Text("Add Item"),
                content: Container(
                    width: 400,
                    height: 200,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Item name',
                              ),
                              onChanged: (String value) {
                                itemName = value;
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length > 15) {
                                  return "Please enter a name (max 15 characters)";
                                }
                                return null;
                              }),
                          TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Item price',
                              ),
                              onChanged: (value) {
                                itemPrice = value;
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    double.tryParse(value) == null) {
                                  return "Please enter a valid price";
                                }
                                return null;
                              }),
                        ],
                      ),
                    )),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            createWishlistItem();
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Add"))
                ],
              );
            });
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget singleWishlistItem(
      String _itemName, String _itemPrice, int index, String docId) {
    return Container(
        padding: const EdgeInsets.all(5),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: 260,
                height: 70,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: totalSavings < double.parse(_itemPrice)
                        ? const Color.fromARGB(255, 250, 98, 98)
                        : const Color.fromARGB(255, 34, 239, 34),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("${index + 1}. $_itemName",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Indies',
                              fontWeight: FontWeight.w500)),
                      Text("\$${double.parse(_itemPrice).toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Indies',
                              fontWeight: FontWeight.w500)),
                    ])),
            ElevatedButton(
                onPressed: () async => {await deleteWishlistItem(docId)},
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 210, 210, 210)),
                ),
                child: Icon(Icons.delete))
          ],
        ));
  }

  Widget wishlistItems() {
    return Container(
        height: 480,
        // width: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: wishlistDocumentFieldStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.requireData;

              if (data.size == 0) {
                return const Text("Add an item to your wishlist!");
              }

              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return singleWishlistItem(
                      data.docs[index]['itemName'],
                      data.docs[index]['itemPrice'],
                      index,
                      data.docs[index].id);
                },
              );
            } else {
              return const Text("Loading...");
            }
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center, // vert center
                children: <Widget>[
                  wishlistItems(),
                  const SizedBox(height: 50),
                  totalSavingsText(),
                ],
              ),
            )),
        floatingActionButton: addItemButton());
  }
}
