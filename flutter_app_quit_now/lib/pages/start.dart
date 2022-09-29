import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_quit_now/pages/register.dart';
import 'login.dart';
import 'rounded_button.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';
import '../auth.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}



class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget _RegisterButton() {
  //do this now!!
    return ElevatedButton(
      onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new RegisterPage())),
      child: Text("Sign Up!"),
      style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(left:37.0, right:37.0),
      ),
    );
  }

 Widget _LoginButton() {
    return ElevatedButton(
      onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginPage())),
      child: const Text('Login!'),
      style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(left:41.0, right:41.0),
      
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[300],
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

            const Text("Quit Now!", style: TextStyle(fontSize: 50, fontFamily:'Indies'), textAlign: TextAlign.center,),
            const SizedBox(height:20),
            Container(
              padding: const EdgeInsets.all(20),
              height: 500,
             decoration: BoxDecoration(
              color: Color.fromARGB(241,250,250,250),
              border: Border.all(
                color: Color.fromARGB(241, 250, 250, 250),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: SingleChildScrollView( child:Column(children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                // ignore: unnecessary_new
                decoration: BoxDecoration(
                  color: Colors.white,
                    image: DecorationImage(
                        image: new AssetImage('assets/images/quitsmoking.png'),
                        fit: BoxFit.cover,
                        opacity: 0.6,
                        
                    ),
                    shape: BoxShape.circle,
                    ),
                ),
              
              const SizedBox(height:20),
              const Text("YOUR PERSONAL SUPPORT SYSTEM TO HELP YOU QUIT SMOKING!", style: TextStyle(fontSize: 25, fontFamily: 'Indies'), textAlign: TextAlign.center,),
              const SizedBox(height:60),
              _LoginButton(),
              const SizedBox(height:10),
              _RegisterButton()
              ]
              ), ),
            ),

              ]),
        ));
  }
}


