import 'package:alma_app/screens_for_customer_button/sign_In_for_customer/components/body.dart';
import 'package:flutter/material.dart';

class SignInScreenC extends StatelessWidget {
  const SignInScreenC({Key? key}) : super(key: key);
  static String routeName = '/sign_in_for_customer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SignIn'),
      ),
      body: const SignInBodyC(),
    );
  }
}
