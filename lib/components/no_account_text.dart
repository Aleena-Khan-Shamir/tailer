import 'package:alma_app/screens_for_customer_button/sign_up_for_customer/sign_up.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Do you have an account?'),
        GestureDetector(
          onTap: () {
            print('SignUp for customer');
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SignUpScreenC()));
            // Navigator.pushNamed(context, SignUpScreenC.routeName);
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
