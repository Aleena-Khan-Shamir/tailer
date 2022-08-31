import 'package:alma_app/authenticationHelper/authentication_helper.dart';
import 'package:alma_app/components/default_button.dart';
import 'package:alma_app/constant.dart';
import 'package:alma_app/widget/profile_widget.dart';
import 'package:alma_app/widget/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreenForCustomer extends StatefulWidget {
  const ProfileScreenForCustomer({Key? key}) : super(key: key);
  static String routeName = '/home_for_customer';
  @override
  State<ProfileScreenForCustomer> createState() =>
      _ProfileScreenForCustomerState();
}

class _ProfileScreenForCustomerState extends State<ProfileScreenForCustomer> {
  var name = 'Loading...';

  var address = 'Area...';

  String? avatar;

  String phonNum = 'phoneNumber...';

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var userData = await FirebaseFirestore.instance
        .collection('userData')
        .doc(user!.uid)
        .get();
    var area = await FirebaseFirestore.instance
        .collection('userData')
        .doc(user.uid)
        .get();
    var img = await FirebaseFirestore.instance
        .collection('userData')
        .doc(user.uid)
        .get();

    var contact = await FirebaseFirestore.instance
        .collection('userData')
        .doc(user.uid)
        .get();
    setState(() {
      name = userData.data()!['username'];
      address = area.data()!['address'];
      avatar = img.data()!['avatarUrl'];

      phonNum = contact.data()!['phoneNumber'];
      //  isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 58.r,
                  backgroundImage: NetworkImage(avatar.toString()),
                ),
              ),
              SizedBox(height: 12.h),
              ProfileWidget(appIcon: const Icon(Icons.person), appData: name),
              SizedBox(height: 12.h),
              ProfileWidget(
                  appIcon: const Icon(Icons.mail_outline),
                  appData: AppConstant.user!.email),
              SizedBox(height: 12.h),
              ProfileWidget(appIcon: const Icon(Icons.phone), appData: phonNum),
              SizedBox(height: 12.h),
              ProfileWidget(
                  appIcon: const Icon(Icons.location_city), appData: address),
              SizedBox(height: 15.h),
              DefaultButton(
                  text: 'LogOut',
                  press: () {
                    AuthenticationHelper.signOut().then((value) =>
                        Navigator.pushNamed(context, WelcomeScreen.routeName));
                  })
            ],
          ),
        ));
  }
}
