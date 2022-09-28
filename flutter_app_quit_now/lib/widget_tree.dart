import 'package:flutter_app_quit_now/auth.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';
import 'package:flutter_app_quit_now/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quit_now/pages/user_details_form.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const LoginPage();
          }
        });
  }
}
