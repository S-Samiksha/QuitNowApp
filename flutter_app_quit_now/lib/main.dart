import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quit_now/pages/firestore_form_test.dart';
import 'package:flutter_app_quit_now/pages/navpage.dart';
import 'package:flutter_app_quit_now/pages/start.dart';
import 'package:flutter_app_quit_now/pages/user_details_form.dart';
import 'package:flutter_app_quit_now/widget_tree.dart';
import 'package:flutter_app_quit_now/pages/login.dart';
import 'package:flutter_app_quit_now/pages/register.dart';
import 'package:flutter_app_quit_now/pages/admit_relapse.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quit Now!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      initialRoute: 'start',
      routes: {
        //'welcome_screen': (context) => WelcomeScreen(),
        'register': (context) => RegisterPage(),
        'login': (context) => LoginPage(),
        //'home_screen': (context) => HomeScreen()
        'user_details_form': (context) => UserDetailsForm(),
        'start': (context) => WelcomeScreen(),
        'admit relapse': (context) => AdmitRelapsePage(),
      },
    );
  }
}
