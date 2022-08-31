import 'package:alma_app/authenticationHelper/authentication_helper.dart';
import 'package:alma_app/components/custom_suffix_icon.dart';
import 'package:alma_app/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyForgotPassword extends StatefulWidget {
  const BodyForgotPassword({Key? key}) : super(key: key);

  @override
  State<BodyForgotPassword> createState() => _BodyForgotPasswordState();
}

class _BodyForgotPasswordState extends State<BodyForgotPassword> {
  // final List<String> errors = [];
  // String? email;
  // String? password;
  // void addError({String? error}) {
  //   if (!errors.contains(error)) {
  //     setState(() {
  //       errors.add(error!);
  //     });
  //   }
  // }

  // void removeError({String? error}) {
  //   if (!errors.contains(error)) {
  //     setState(() {
  //       errors.remove(error!);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(height: 0.04.sh),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 25.sp,
                      color: Colors.black,
                      fontFamily: 'BebasNeue',
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Please enter your email and we will send\n you a link to return to your account',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50.h),
                const ForgotPassForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailC = TextEditingController();
  // List<String> errors = [];
  // String? email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailC,
            // onSaved: (newValue) {
            //   email = newValue;
            // },
            // onChanged: (value) {
            //   if (value.isNotEmpty && errors.contains(kEmailNullError)) {
            //     setState(() {
            //       errors.remove(kEmailNullError);
            //     });
            //   } else if (value.length < 8 &&
            //       errors.contains(kInvalidEmailError)) {
            //     setState(() {
            //       errors.remove(kInvalidEmailError);
            //     });
            //   }
            // },
            // validator: (value) {
            //   if (value!.isEmpty && !errors.contains(kEmailNullError)) {
            //     setState(() {
            //       errors.add(kEmailNullError);
            //     });
            //   } else if (!emailValidatorRegExp.hasMatch(value) &&
            //       !errors.contains(kInvalidEmailError)) {
            //     setState(() {
            //       errors.add(kInvalidEmailError);
            //     });
            //   }
            //   return null;
            // },
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSuffixIcon(
                svgIcon: "assets/icons/Mail.svg",
              ),
            ),
          ),
          SizedBox(height: 15.w),
          //FormError(errors: errors),
          SizedBox(height: 50.h),
          DefaultButton(
              text: 'Reset Password',
              press: () {
                if (_formKey.currentState!.validate()) {
                  //Do what you want to do
                  AuthenticationHelper.resetPassword(emailC.text);
                }
              }),
          // SizedBox(height: 10.h),
          // NoAccountText(
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}
