import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_auth/firebase_auth.dart';

// const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryColor = Color(0xFF6A1B9A);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

//From Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your Emial";
const String kInvalidEmailError = "Please Enter your Valid email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too  short";
const String kMatchPassError = "Password don't match";
const String kNameNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
// final otpInputDecoration = InputDecoration(
//   contentPadding: EdgeInsets.symmetric(vertical: 9.w),
//   enabledBorder: outlineInputBorder(),
//   focusedBorder: outlineInputBorder(),
//   border: outlineInputBorder(),
// );

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: kTextColor));
}

class AppConstant {
  final FirebaseAuth? auth = FirebaseAuth.instance;
  static final User? user = FirebaseAuth.instance.currentUser!;
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
