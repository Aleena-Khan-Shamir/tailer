import 'package:alma_app/screens_for_customer_button/sign_up_for_customer/components/body.dart';
import 'package:flutter/material.dart';

class SignUpScreenC extends StatelessWidget {
  const SignUpScreenC({Key? key}) : super(key: key);
  static String routeName = '/sign_up_for_customer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignUp for Customer')),
      body: const BodySignUpC(),
    );
  }
}
