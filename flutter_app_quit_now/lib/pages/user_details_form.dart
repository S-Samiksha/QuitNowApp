import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_quit_now/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';

class UserDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tell us more about you!')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const MyCustomForm()],
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final User? user = Auth().currentUser;
  final Stream<QuerySnapshot> userDetails =
      FirebaseFirestore.instance.collection('userdetails').snapshots();

  var name = '';
  var sticksPerDay = 0;
  var costPerPack = 0;
  var sticksPerPack = 0;
  var quitDate = '';

  @override
  Widget build(BuildContext context) {
    CollectionReference userDetails =
        FirebaseFirestore.instance.collection('userdetails');

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {
                name = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text";
                }
                return null;
              }),
          TextFormField(
              decoration: const InputDecoration(
                labelText: 'Sticks per Day',
              ),
              onChanged: (value) {
                sticksPerDay = int.parse(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }),
          TextFormField(
              decoration: const InputDecoration(
                labelText: 'Cost per Pack',
              ),
              onChanged: (value) {
                costPerPack = int.parse(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }),
          TextFormField(
              decoration: const InputDecoration(
                labelText: 'Sticks per Pack',
              ),
              onChanged: (value) {
                sticksPerPack = int.parse(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }),
          TextFormField(
              decoration: const InputDecoration(
                labelText: 'Quit Date',
              ),
              onChanged: (value) {
                quitDate = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sending Data to DB'),
                    ),
                  );

                  userDetails
                      .doc(user?.uid) // DOC ID
                      .set({
                        'name': name,
                        'sticksPerDay': sticksPerDay,
                        'costPerPack': costPerPack,
                        'sticksPerPack': sticksPerPack,
                        'quitDate': quitDate
                      }) // this will add if ID does not exist, update if it does
                      .then((value) => print('Details Added'))
                      .catchError(
                          (error) => print('Failed to add details: $error'));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
