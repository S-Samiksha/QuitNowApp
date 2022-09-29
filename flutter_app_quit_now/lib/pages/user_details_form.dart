import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_quit_now/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';

class UserDetailsForm extends StatelessWidget {
  const UserDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: const [MyCustomForm()],
      //   ),
      // ),
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
              const SizedBox(height: 80),
              const Text(
                "Tell us more about you",
                style: TextStyle(fontSize: 25, fontFamily: 'Indies'),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                height: 400,
                decoration: BoxDecoration(
                    color: Color.fromARGB(241, 250, 250, 250),
                    border: Border.all(
                      color: Color.fromARGB(241, 250, 250, 250),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    children: const [MyCustomForm()],
                  ),
                ),
              )
            ],
          ),
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
                icon: Icon(Icons.person),
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
                icon: Icon(Icons.smoking_rooms),
                labelText: 'Sticks Smoked per Day',
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
                icon: Icon(Icons.attach_money),
                labelText: 'Cost of One Pack',
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
                icon: Icon(Icons.shopping_cart_sharp),
                labelText: 'Sticks in One Pack',
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
                icon: Icon(Icons.calendar_month_sharp),
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

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
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
