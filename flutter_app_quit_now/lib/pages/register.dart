import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_quit_now/pages/user_details_form.dart';
import 'rounded_button.dart';
import '../auth.dart';
import 'package:flutter_app_quit_now/pages/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;
  String Email = '\0';
  String Password = '\0';
  String ConfirmPassword = '\0';

  //final TextEditingController _controllerEmail = TextEditingController();
  //final TextEditingController _controllerPassword = TextEditingController();

  Future<bool> createUserWithEmailAndPassword() async {
    try {
      if (Password.length<8){
        throw Exception("Password needs to be 8 Characters Long!");
      }

      if (!RegExp(
              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
          .hasMatch(Password)) {
        throw Exception(
            "Password must contain one uppercase letter, one lowercase letter, one number and one special character");
      }

      if (Password != ConfirmPassword) {
        throw Exception("Passwords must match");
      }


      await Auth().createUserWithEmailAndPassword(
        email: Email,
        password: Password,
        confirmPassword: ConfirmPassword,
      );

      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      return Future.value(false);
    } on Exception catch (e) {
      setState(() {
        errorMessage = (e.toString()).substring(11);
      });
      return Future.value(false);
    }
  }

  Widget _title() {
    return const Text('Quit Now!');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  bool success = false;
  Widget _submitButton() {
    width:
    300;
    return ElevatedButton(
      onPressed: () async => {
        if (await createUserWithEmailAndPassword())
          {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => UserDetailsForm()))
          }
      },
      child: const Text("Register!"),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.only(left: 44.0, right: 44.0),
      ),
    );
  }

  Widget _LoginButton() {
    width:
    300;
    return ElevatedButton(
      onPressed: () => Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new LoginPage())),
      child: const Text('Login instead!'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      ),
    );
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
        color: Colors.orange[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                // ignore: unnecessary_new
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: new AssetImage('assets/images/arrowdown.png'),
                    fit: BoxFit.cover,
                    opacity: 0.6,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Register",
                style: TextStyle(fontSize: 25, fontFamily: 'Indies'),
              ),
              const SizedBox(height: 10),
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
                    children: <Widget>[
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            Email = value;
                          },
                          decoration:
                              const InputDecoration(label: Text('Email'))),
                      TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            Password = value;
                          },
                          decoration:
                              const InputDecoration(label: Text('Password'))),
                      TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            ConfirmPassword = value;
                          },
                          decoration: const InputDecoration(
                              label: Text('Confirm Password'))),
                      _errorMessage(),
                      const SizedBox(height: 30),
                      _submitButton(),
                      const SizedBox(height: 10),
                      _LoginButton()
                    ],
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
