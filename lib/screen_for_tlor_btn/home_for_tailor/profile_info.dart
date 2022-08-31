import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInfo extends StatefulWidget {
  final String uid;
  const ProfileInfo({
    Key? key,
    required this.uid,
  }) : super(key: key);
  static String routeName = '/home_for_tailor';

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  var name = 'Loading...';
  var firstName = 'Loading...';
  var address = 'Area...';
  String? avatar;
  int postLen = 0;
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

    var postSnap = await FirebaseFirestore.instance
        .collection('post')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    // try {
    //   var userSnap =
    //       await FirebaseFirestore.instance.collection('userData').doc().get();

    //   // get post lENGTH
    //   var postSnap = await FirebaseFirestore.instance
    //       .collection('post')
    //       .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //       .get();

    //   postLen = postSnap.docs.length;
    //   userData = userSnap.data()!;

    //   setState(() {});
    // } catch (e) {
    //   showSnackBar(e.toString(), context);
    // }
    setState(() {
      name = userData.data()!['username'];
      firstName = userData.data()!['firstName'];
      address = userData.data()!['address'];
      avatar = userData.data()!['avatarUrl'];
      postLen = postSnap.docs.length;
      phonNum = userData.data()!['phoneNumber'];

      //  isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final data = widget.snap.data();
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                name,
              ),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            //backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(avatar == null
                                ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                                : avatar.toString()),
                            radius: 40.r,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(phonNum, address),
                                    buildStatColumn(
                                        postLen.toString(), "posts"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          top: 15.h,
                        ),
                        child: Text(
                          firstName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('post')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 3,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                        return Container(
                          child: Image(
                            image: NetworkImage(snap['imageUrl']),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
  }

  Column buildStatColumn(String num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
