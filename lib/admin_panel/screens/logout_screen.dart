import 'package:alma_app/constant.dart';
import 'package:alma_app/widget/welcome_screen.dart';
import 'package:flutter/material.dart';

class LogOutScreen extends StatelessWidget {
  const LogOutScreen({Key? key}) : super(key: key);
  static const String routeName = '/logout_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        child: const Text(
          'Log Out',
          style: TextStyle(color: kPrimaryColor),
        ),
        onPressed: () {
          Navigator.pushNamed(context, WelcomeScreen.routeName);
        },
      )),
    );
  }
}
