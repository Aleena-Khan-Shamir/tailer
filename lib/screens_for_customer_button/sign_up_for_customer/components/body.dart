import 'package:alma_app/screens_for_customer_button/sign_up_for_customer/components/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodySignUpC extends StatelessWidget {
  const BodySignUpC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              SizedBox(
                height: 0.05.sw,
              ),
              Text(
                'Register Account',
                style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                    color: Colors.black),
              ),
              const Text(
                'Complete your details or continue \nwith social media',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.04.sh),
              SignUpFormC(),
              SizedBox(height: 0.04.sh),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SocialCard(icon: 'assets/icons/facebook.svg', press: () {}),
              //     SizedBox(width: 0.03.sw),
              //     SocialCard(
              //         icon: 'assets/icons/google-icon.svg', press: () {}),
              //   ],
              // ),
              SizedBox(height: 0.03.sw),
              const Text(
                'By continuing your confirm that you agree\n with your Term and Condition',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
