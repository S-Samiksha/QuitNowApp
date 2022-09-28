import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_quit_now/pages/register.dart';
import 'rounded_button.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<bool> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
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

  Widget _submitButton() {
     return ElevatedButton(
      onPressed: () async => {
        if (await signInWithEmailAndPassword())
          {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()))
          }
      },
      child: const Text('Login!'),
    );
  }


Widget _RegisterButton() {
  //do this now!!
    return ElevatedButton(
      onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new RegisterPage())),
      child: Text("Don't Have An Account? Register!"),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('Email', _controllerEmail),
            _entryField('Password', _controllerPassword),
            _errorMessage(),
            _submitButton(),
            _RegisterButton(),
          ],
        ),
      ),
    );
  }
}
