import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< Updated upstream
import 'package:flutter_app_quit_now/pages/user_details_form.dart';
=======
import 'rounded_button.dart';
>>>>>>> Stashed changes
import '../auth.dart';
import 'package:flutter_app_quit_now/pages/login.dart';

<<<<<<< Updated upstream
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
=======
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
>>>>>>> Stashed changes
  String? errorMessage = '';
  bool isLogin = true;
  String Email = '\0';
  String Password = '\0';
  String ConfirmPassword = '\0';

<<<<<<< Updated upstream
  //final TextEditingController _controllerEmail = TextEditingController();
  //final TextEditingController _controllerPassword = TextEditingController();


Future<void> createUserWithEmailAndPassword() async {
=======
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  Future<void> createUserWithEmailAndPassword() async {
>>>>>>> Stashed changes
    try {
       await Auth().createUserWithEmailAndPassword(
        email: Email,
        password: Password,
        confirmPassword: ConfirmPassword,
      );
        
      () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new UserDetailsForm()));
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
<<<<<<< Updated upstream

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: createUserWithEmailAndPassword,

      child: Text("Register!"),
    );
  }

Widget _RegisterButton() {
  //do this now!!
    return ElevatedButton(
      onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginPage())),
      child: Text("Already Have An Account? Login!"),
=======
 Widget _RegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
>>>>>>> Stashed changes
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
                  decoration: const InputDecoration(label: Text('Confirm Password')),
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                  }else if (value != Password){
                    return 'Passwords do not match!';
                  }
                return null;}
                ),
            _errorMessage(),
<<<<<<< Updated upstream
            _submitButton(),
=======
>>>>>>> Stashed changes
            _RegisterButton(),
          ],
        ),
      ),
    );
  }
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
}