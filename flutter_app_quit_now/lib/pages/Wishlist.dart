import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quit_now/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_quit_now/pages/admit_relapse.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';
import 'package:flutter_app_quit_now/pages/login.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final User? user = Auth().currentUser;

  final Stream<QuerySnapshot> userDetails =
      FirebaseFirestore.instance.collection('userdetails').snapshots();

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    return FirebaseFirestore.instance
        .collection('userdetails')
        .doc(user?.uid)
        .snapshots();
  }

  Widget _title() {
    return const Text('Your Wish List');
  }

  List todos = List.empty();
  String title = "";
  String description = "";
  @override
  void initState() {
    super.initState();
    todos = ["Hello", "Hey There"];
  }

  // createToDo() {
  //   DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection("MyTodos").doc(title);

  //   Map<String, String> todoList = {
  //     "todoTitle": title,
  //     "todoDesc": description
  //   };

  //   documentReference
  //       .set(todoList)
  //       .whenComplete(() => print("Data stored successfully"));
  // }
  Future<String?> createToDo({String? uid}) async {
    CollectionReference userDetails =
        FirebaseFirestore.instance.collection('userdetails');
    userDetails
        .doc(user?.uid) //how to retrieve the id...
        .collection('Wishlist')
        .add({'todoTitle': title, 'todoDesc': description});
  }

  deleteTodo(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTodos").doc(item);

    documentReference
        .delete()
        .whenComplete(() => print("deleted successfully"));
  }

  Widget addItemButton() {
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
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Item name',
                        ),
                        onChanged: (String value) {
                          title = value;
                        },
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Item price',
                        ),
                        onChanged: (String value) {
                          description = value;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        setState(() {
                          //todos.add(title);
                          createToDo();
                        });
                        Navigator.of(context).pop();
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
            children: const <Widget>[
              SizedBox(height: 10),
            ],
          ),
        ),
        floatingActionButton: addItemButton());
  }
}
