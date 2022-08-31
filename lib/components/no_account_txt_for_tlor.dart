import 'package:alma_app/screen_for_tlor_btn/signUp/sign_up.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class NoAccountTextT extends StatelessWidget {
  const NoAccountTextT({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Do you have an account?'),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreenT.routeName),
          child: const Text(
            'Sign Up',
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
