import 'package:alma_app/admin_panel/screens/dashboard_screen.dart';
import 'package:alma_app/admin_panel/screens/logout_screen.dart';
import 'package:alma_app/admin_panel/screens/setting.dart';
import 'package:alma_app/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/admin_home_screen';

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // var name = 'Loading...';

  // String? avatar;
  // var userData;
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  // getData() async {
  //   // User? user = FirebaseAuth.instance.currentUser;
  //   // var userData = await FirebaseFirestore.instance
  //   //     .collection('userData')
  //   //     .doc(user!.uid)
  //   //     .get();

  //   // try {
  //   //   var userSnap =
  //   //       await FirebaseFirestore.instance.collection('userData').doc().get();

  //   //   // get post lENGTH
  //   //   var postSnap = await FirebaseFirestore.instance
  //   //       .collection('post')
  //   //       .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //   //       .get();

  //   //   //  postLen = postSnap.docs.length;
  //   //   userData = userSnap.data()!;

  //   //   setState(() {});
  //   // } catch (e) {
  //   //   showSnackBar(e.toString(), context);
  //   // }
  //   setState(() {
  //     name = userData.data()!['username'];

  //     avatar = userData.data()!['avatarUrl'];

  //     //  isLoading = false;
  //   });
  // }

  Widget _selectedScreen = DashboardScreen();
  currentScreen(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedScreen = DashboardScreen();
        });
        break;
      case SettingsScreen.routeName:
        setState(() {
          _selectedScreen = const SettingsScreen();
        });
        //Navigator.pop(context);
        break;
      case LogOutScreen.routeName:
        setState(() {
          _selectedScreen = const LogOutScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashboardScreen.routeName,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
              title: 'Setting',
              route: SettingsScreen.routeName,
              icon: Icons.settings),
          AdminMenuItem(
              title: 'Log out',
              route: LogOutScreen.routeName,
              icon: Icons.logout),
        ],
        selectedRoute: AdminHome.routeName,
        onSelected: (item) {
          currentScreen(item);
          // if (item.route != null) {
          //   Navigator.of(context).pushNamed(item.route!);
          // }
        },
        header: Container(
          height: 200.h,
          width: double.infinity,
          color: kPrimaryColor,
          child: Center(
            child: CircleAvatar(
              radius: 40.r,
              backgroundImage: NetworkImage(''
                  // avatar == null
                  //     ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                  //     : avatar.toString(),
                  ),
            ),
          ),
        ),
        // footer: Container(
        //   height: 50,
        //   width: double.infinity,
        //   color: const Color(0xff444444),
        //   child: const Center(
        //     child: Text(
        //       'footer',
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: _selectedScreen,
    );
  }
}
