import 'package:alma_app/authenticationHelper/authentication_helper.dart';
import 'package:alma_app/components/custom_suffix_icon.dart';
import 'package:alma_app/components/default_button.dart';
import 'package:alma_app/screen_for_tlor_btn/completeProfile/complete_profile.dart';
import 'package:alma_app/screens_for_customer_button/completeprofile_for_customer/complete_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant.dart';

class SignUpFormC extends StatelessWidget {
  SignUpFormC({
    Key? key,
  }) : super(key: key);
  String? confirmPass;
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  //String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    print('Customer register account');
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 15.h),
          buildPasswordFormField(),
          SizedBox(height: 15.h),
          buildConfirmPassFormField(),
          SizedBox(height: 15.h),
          DefaultButton(
              text: "Continue",
              press: () {
                //When your email field is empty it shows the please enter your email
                // print('email: ${emailC.text} ');
                // print('password: ${passwordC.text} ');
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  AuthenticationHelper.signUp(emailC.text, passwordC.text);
                  Navigator.pushNamed(
                      context, CompleteProfileScreenC.routeName);
                }
                //If all are valid then go to success screen
              }),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please renter password';
        } else if (value.length < 8) {
          return 'Must be more than 8 charater';
        } else if (value != confirmPass) {
          return "Password does not match";
        } else {
          return null;
        }
      },
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Renter your password',
        labelText: 'Confirm Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: 'assets/icons/Lock.svg',
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordC,
      validator: (value) {
        confirmPass = value;
        if (value!.isEmpty) {
          return 'Please enter some text';
        } else if (value.length < 8) {
          return 'Must be more than 8 charater';
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        } else if ((!emailValidatorRegExp.hasMatch(value))) {
          return kInvalidEmailError;
        }
        return null;
      },
      controller: emailC,
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
}
