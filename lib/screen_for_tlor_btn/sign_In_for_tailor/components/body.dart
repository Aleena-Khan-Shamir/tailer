import 'package:alma_app/authenticationHelper/authentication_helper.dart';
import 'package:alma_app/components/custom_suffix_icon.dart';
import 'package:alma_app/components/no_account_txt_for_tlor.dart';
import 'package:alma_app/components/social_card.dart';
import 'package:alma_app/screen_for_tlor_btn/sign_In_for_tailor/components/sign_in_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home_for_tailor/home_screen.dart';

class SignInBodyT extends StatefulWidget {
  const SignInBodyT({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInBodyT> createState() => _SignInBodyTState();
}

class _SignInBodyTState extends State<SignInBodyT> {
  @override
  Widget build(BuildContext context) {
    // final google = Provider.of<GoogleSignInProvider>(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40.h),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontFamily: 'BebasNeue'),
                ),
                const Text(
                  'SignIn with your email and password\n or continue with social media',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                const SignInFormForT(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: 'assets/icons/facebook.svg',
                      press: () {
                        AuthenticationHelper.signInWithFacebook().then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TailorHomeScreen()),
                          ),
                        );
                      },
                    ),
                    SocialCard(
                      icon: 'assets/icons/google-icon.svg',
                      press: () {
                        AuthenticationHelper.signInWithGoogle().then((value) =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TailorHomeScreen())));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                const NoAccountTextT(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextFormField buildPasswordFormField() {
  return TextFormField(
    obscureText: true,
    decoration: const InputDecoration(
      hintText: 'Enter your password',
      labelText: 'Password',
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: CustomSuffixIcon(
        svgIcon: 'assets/icons/Lock.svg',
      ),
    ),
  );
}

TextFormField buildEmailFormField() {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      hintText: 'Enter your email',
      labelText: 'Email',
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: CustomSuffixIcon(
        svgIcon: 'assets/icons/Mail.svg',
      ),
    ),
  );
}
