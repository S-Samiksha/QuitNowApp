import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_quit_now/pages/user_details_form.dart';
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
      await Auth().createUserWithEmailAndPassword(
        email: Email,
        password: Password,
        confirmPassword: ConfirmPassword,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return Future.value(false);
    } catch (e) {
      print(e);
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
    return ElevatedButton(
      onPressed: () async => {
        if (await createUserWithEmailAndPassword())
          {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new UserDetailsForm()))
          }
      },
      child: Text("Register!"),
    );
  }

  Widget _RegisterButton() {
    //do this now!!
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage())),
      child: const Text("Already Have An Account? Login!"),
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
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  Email = value;
                  //Do something with the user input.
                },
                decoration: const InputDecoration(label: Text('Email'))),
            TextFormField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  Password = value;
                  //Do something with the user input.
                },
                decoration: const InputDecoration(label: Text('Password'))),
            TextFormField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  ConfirmPassword = value;
                  //Do something with the user input.
                },
                decoration:
                    const InputDecoration(label: Text('Confirm Password')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value != Password) {
                    return 'Passwords do not match!';
                  }
                  return null;
                }),
            _errorMessage(),
            _submitButton(),
            _RegisterButton(),
          ],
        ),
      ),
    );
  }
}
