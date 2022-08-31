import 'package:alma_app/screens_for_customer_button/sign_In_for_customer/sign_in.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alma_app/components/default_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen_for_tlor_btn/sign_In_for_tailor/sign_in.dart';
import '../screen_for_visitor/visitor.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String routeName = 'home_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 0.09.sh),
              Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 35.sp,
                    color: Colors.black,
                    fontFamily: 'BebasNeue'),
              ),
              const Text('This is specially for you'),
              const Spacer(flex: 2),
              DefaultButton(
                press: () {
                  print('Customer1');
                  // check_if_already_login();

                  Navigator.pushNamed(context, SignInScreenC.routeName);
                },
                text: 'As a Customer',
              ),
              SizedBox(
                height: 13.h,
              ),
              DefaultButton(
                press: () {
                  // Navigator.pushNamed(context, LandingScreenTlr.routeName);
                  Navigator.pushNamed(context, SignInScreenT.routeName);
                },
                text: 'As a Tailor',
              ),
              SizedBox(
                height: 13.h,
              ),
              DefaultButton(
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const VisitorScreen()));
                },
                text: 'As a Visitor',
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

//   SharedPreferences? sharedPreferences;
//   bool? userBool;
// //TODO: "WelcomeScreen" check_if_already_login method
//   void check_if_already_login() async {

//     sharedPreferences = await SharedPreferences.getInstance();
//     userBool = (sharedPreferences!.getBool('login') ?? false);
//     print('userBool: ${userBool.toString()}');

//       if(userBool == true){
//         Future.delayed(
//           Duration(seconds: 3),
//               () =>   Navigator.pushNamed(
//                   context, CustomerHomeScreen.routeName),
//         );
//       }
//       else{
//         Future.delayed(
//             const Duration(seconds: 3),
//                 () =>  Navigator.pushNamed(
//                     context, SignInScreenForCustomer.routeName),);
//       }

//     setState(() {});
//   }

}
