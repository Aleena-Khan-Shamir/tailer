import 'package:alma_app/screen_for_tlor_btn/sign_In_for_tailor/components/body.dart';
import 'package:flutter/material.dart';

class SignInScreenT extends StatelessWidget {
  const SignInScreenT({Key? key}) : super(key: key);
  static String routeName = '/sign_in_for_tailor';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SignIn'),
      ),
      body: const SignInBodyT(),
    );
  }
}
