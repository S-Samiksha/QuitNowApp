import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< Updated upstream
import 'package:flutter_app_quit_now/pages/register.dart';
=======
import 'rounded_button.dart';
>>>>>>> Stashed changes
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
<<<<<<< Updated upstream

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = false;
=======
class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
>>>>>>> Stashed changes

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
<<<<<<< Updated upstream


=======
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
  Widget _submitButton() {
    return ElevatedButton(
      onPressed: signInWithEmailAndPassword,
      child: Text('Login!'),
    );
  }


Widget _RegisterButton() {
  //do this now!!
    return ElevatedButton(
      onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new RegisterPage())),
      child: Text("Don't Have An Account? Register!"),
    );
  }


=======
Widget _loginButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
            _errorMessage(),
            _submitButton(),
            _RegisterButton(),
=======
            _entryField('Confirm Passowrd', _controllerPassword),
            _errorMessage(),
            _loginButton(),
>>>>>>> Stashed changes
          ],
        ),
      ),
    );
  }
<<<<<<< Updated upstream
}
=======
}
>>>>>>> Stashed changes
