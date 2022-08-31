import 'package:alma_app/authenticationHelper/authentication_helper.dart';
import 'package:alma_app/components/custom_suffix_icon.dart';
import 'package:alma_app/components/default_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../admin_panel/admin_home_screen.dart';
import '../../../components/forgot_password/forgot_password_screen.dart';
import '../../../constant.dart';
import '../../../screens_for_customer_button/home_for_customer/customer_home_screen.dart';
import '../../home_for_tailor/home_screen.dart';

class SignInFormForT extends StatefulWidget {
  const SignInFormForT({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInFormForT> createState() => _SignInFormForTState();
}

class _SignInFormForTState extends State<SignInFormForT> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String _text = '';

  final _formKey = GlobalKey<FormState>();

  //String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 15.h),
          buildPasswordFormField(),
          SizedBox(height: 15.h),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
            },
            child: const Text(
              'Forgot password?',
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 28.h),
          DefaultButton(
              text: "Sign In",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  // setState(() {
                  //   isLoadingButton = true;
                  // });
                  try {
                    await AuthenticationHelper.auth!.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.blueGrey,
                        content: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Successfully login'),
                        ),
                        duration: Duration(seconds: 3),
                      ),
                    );

                    String username = emailController.text;
                    String password = passwordController.text;

                    if (username == 'peter@gmail.com' &&
                        password == '12345678') {
                      Navigator.pushNamed(context, AdminHome.routeName);
                      // SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      // await prefs
                      //     .setBool('login', true)
                      //     .then((value) => print(value));
                      // await prefs
                      //     .setString('username', username)
                      //     .then((value) => print(value));
                      // print('loginData bool value:${prefs.toString()}');
                      // print('login:${prefs.toString()}');

                      // AppRoutes.makeFirst(context, BottomDashBoardScreen());
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TailorHomeScreen()));
                    }
                    // setState(() {
                    //   isLoadingButton = false;
                    // });
                  } on FirebaseAuthException catch (e) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Ops! Login Failed"),
                        content: Text('${e.message}'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text('Okay'),
                          )
                        ],
                      ),
                    );
                    print(e);
                  }
                  // setState(() {
                  //   isLoadingButton = false;
                  // });
                }

                // setState(() {
                //   isLoading = true;
                // });
                //When your email field is empty it shows the please enter your email
                // print('email: ${emailController.text} ');
                // print('password: ${passwordController.text} ');
                // if (_formKey.currentState!.validate()) {
                //   AuthenticationHelper.signIn(
                //     emailController.text,
                //     passwordController.text,
                //   ).then((value) {
                //     print('value: ${value.toString()} ');
                //  Navigator.push(context,
                //   MaterialPageRoute(builder: (_) => TailorHomeScreen()));
                // });
              }
              // setState(() {
              //   isLoading = false;
              // });
              //If all are valid then go to success screen
              // }
              ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        } else if (value.length < 8) {
          return 'Must be more than 8 charater';
        }
        return null;
      },
      onChanged: (value) => setState(() => _text = value),
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
      controller: emailController,
      decoration: const InputDecoration(
        hintText: 'Enter your email',
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: 'assets/icons/Mail.svg',
        ),
      ),
      onChanged: (value) => setState(() {
        value = _text;
      }),
    );
  }
}
