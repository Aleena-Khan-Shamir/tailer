import 'package:alma_app/screens_for_customer_button/completeprofile_for_customer/component/body.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreenC extends StatelessWidget {
  const CompleteProfileScreenC({Key? key}) : super(key: key);
  static String routeName = '/completeprofile_for_customer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Complete Profile For Customer'),
      ),
      body: const BodyCPCustomer(),
    );
  }
}
