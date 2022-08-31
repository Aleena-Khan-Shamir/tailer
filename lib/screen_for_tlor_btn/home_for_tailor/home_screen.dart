import 'package:alma_app/authenticationHelper/authentication_helper.dart';
import 'package:alma_app/constant.dart';
import 'package:alma_app/firebase_services/firestoremethod.dart';
import 'package:alma_app/screen_for_tlor_btn/home_for_tailor/post_card.dart';
import 'package:alma_app/screen_for_tlor_btn/home_for_tailor/profilescreen.dart';
import 'package:alma_app/video/uploadvideo.dart';
import 'package:alma_app/widget/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../photo/phot_screen.dart';

class TailorHomeScreen extends StatefulWidget {
  TailorHomeScreen({Key? key}) : super(key: key);
  static String routeName = '/home';

  @override
  State<TailorHomeScreen> createState() => _TailorHomeScreenState();
}

class _TailorHomeScreenState extends State<TailorHomeScreen> {
  var name = 'Loading...';
  String? avatar;
  Future? dataFuture;
  @override
  void initState() {
    super.initState();
    dataFuture = FirestoreMethod.getPost();
    getData();
  }

  getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var userData = await FirebaseFirestore.instance
        .collection('userData')
        .doc(user!.uid)
        .get();

    setState(() {
      name = userData.data()!['username'];
      avatar = userData.data()!['avatarUrl'];

      //  isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            dataFuture = FirestoreMethod.getPost();
          });
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.refresh,
        ),
      ),
      body: FutureBuilder(
        future: dataFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => PostCardForTailor(
              snap: snapshot.data!.docs[index],
            ),
          );
        },
      ),
      // body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      //   stream: FirebaseFirestore.instance.collection('post').snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }

      //     return ListView.builder(
      //       shrinkWrap: true,
      //       itemCount: snapshot.data!.docs.length,
      //       itemBuilder: (ctx, index) => PostCardForTailor(
      //         snap: snapshot.data!.docs[index],
      //       ),
      //     );
      //   },
      // ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: kPrimaryColor),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(avatar == null
                              ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                              : avatar.toString()
                          // AppConstant.user!.displayName == null
                          //     ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                          //     : AppConstant.user!.photoURL.toString()
                          ),
                    ),
                    accountName: Text(name
                        // AppConstant.user!.displayName == null
                        //     ? "no name"
                        //     : AppConstant.user!.displayName.toString(),

                        ),
                    accountEmail: Text(AppConstant.user!.email == null
                        ? "no email"
                        : AppConstant.user!.email.toString())),
              ],
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.profile_circled),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, ProfileS.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text(
                'Upload Picture',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pushNamed(context, PhotoPreviewScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_file),
              title: const Text(
                'Upload video',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pushNamed(context, Videoo.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Log out',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                AuthenticationHelper.signOut().then((value) =>
                    Navigator.pushNamed(context, WelcomeScreen.routeName));
              },
            )
          ],
        ),
      ),
    );
  }
}
