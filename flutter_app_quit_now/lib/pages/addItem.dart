import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quit_now/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_quit_now/pages/Wishlist.dart';
import 'package:flutter_app_quit_now/pages/admit_relapse.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';
import 'package:flutter_app_quit_now/pages/login.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  Widget _title() {
    return const Text('Add Item');
  }

// //need to update
  Widget _addButton() {
    //do this now!!
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage())),
      child: Text("Add Item"),
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
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              height: 200,
              decoration: BoxDecoration(
                  color: Color.fromARGB(241, 250, 250, 250),
                  border: Border.all(
                    color: Color.fromARGB(241, 250, 250, 250),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(
                  children: const [AddForm()],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _addButton(),
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
            icon: Icon(Icons.home_filled),
            label: 'HomePage',
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

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final User? user = Auth().currentUser;
  final Stream<QuerySnapshot> userDeatils =
      FirebaseFirestore.instance.collection('userdetails').snapshots();

  var name = '';
  var price = 0;

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
                    labelText: 'Item name',
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
                    labelText: 'Item price',
                  ),
                  onChanged: (value) {
                    price = int.parse(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  }),
              // const SizedBox(height: 10),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       if (_formKey.currentState!.validate()) {
              //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //           content: Text('Sending Data to DB'),
              //         ));

              //         userDetails
              //             .doc(user?.uid) //DO ID
              //             .set({'item_name': name, 'item_price': price})
              //             .then((value) => print('Details Added'))
              //             .catchError((error) =>
              //                 print('Failed to add details: $error'));

              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => const WishlistPage()));
              //       }
              //     },
              //     child: const Text('Add Item'),
              //   ),
              // ),
            ]));
  }
}
