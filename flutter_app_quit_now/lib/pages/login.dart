import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_quit_now/pages/navpage.dart';
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
  String Email = '\0';
  String Password = '\0';

  //final TextEditingController _controllerEmail = TextEditingController();
  //final TextEditingController _controllerPassword = TextEditingController();

  Future<bool> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: Email,
        password: Password,
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
                MaterialPageRoute(builder: (context) => const NavPage()))
          }
      },
      child: const Text('Login!'),
    );
  }

  Widget _RegisterButton() {
    //do this now!!
    return ElevatedButton(
      onPressed: () => Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new RegisterPage())),
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
                "Login",
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
                          decoration: const InputDecoration(
                              icon: Icon(Icons.email), label: Text('Email'))),
                      TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            Password = value;
                          },
                          decoration: const InputDecoration(
                              icon: Icon(Icons.lock_outline),
                              label: Text('Password'))),
                      _errorMessage(),
                      const SizedBox(height: 60),
                      _submitButton(),
                      const SizedBox(height: 10),
                      _RegisterButton()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
