import 'package:alma_app/screen_for_tlor_btn/completeProfile/component/body.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreenT extends StatelessWidget {
  const CompleteProfileScreenT({Key? key}) : super(key: key);
  static String routeName = '/complete_profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Complete Profile'),
      ),
      body: const BodyCPTailor(),
    );
  }
}
