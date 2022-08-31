import 'package:alma_app/screen_for_tlor_btn/signUp/components/body.dart';
import 'package:flutter/material.dart';

class SignUpScreenT extends StatelessWidget {
  const SignUpScreenT({Key? key}) : super(key: key);
  static String routeName = '/sign_up';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up'),
      ),
      body: const BodySignUpT(),
    );
  }
}
