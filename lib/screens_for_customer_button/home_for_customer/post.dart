import 'package:alma_app/firebase_services/firestoremethod.dart';
import 'package:alma_app/provider/user_provider.dart';
import 'package:alma_app/screens_for_customer_button/home_for_customer/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class PostCardForCustomer extends StatefulWidget {
  final snap;
  const PostCardForCustomer({Key? key, required this.snap}) : super(key: key);
  static String routeName = '/home_for_customer';

  @override
  State<PostCardForCustomer> createState() => _PostCardForCustomerState();
}

class _PostCardForCustomerState extends State<PostCardForCustomer> {
  bool isLiked = false;

  var address = 'Area...';
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    var userSnap = await FirebaseFirestore.instance
        .collection('userData')
        .doc(user!.uid)
        .get();

    setState(() {
      address = userSnap.data()!['address'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.snap.data();

    final Userr? user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Container(
        height: 540.h,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Container(
                      height: 50.h,
                      width: 50.h,
                      // padding:
                      //     EdgeInsets.symmetric(vertical: 9.h, horizontal: 16.w),
                      child: CircleAvatar(
                        child: ClipOval(
                            child: Image(
                          height: 50.h,
                          width: 50.w,
                          image: NetworkImage(data['avatarUrl']),
                          fit: BoxFit.cover,
                        )),
                      ),
                    ),
                    title: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProfileInfoForCustomer(
                                      uid: data['uid'],
                                    )));
                      },
                      child: Text(
                        data['username'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    subtitle: Text(address),
                  ),

                  //Image Section
                  SizedBox(
                    height: 350.h,
                    width: double.infinity,
                    child: Image.network(
                      data['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      FirestoreMethod().likePost(
                        data['postId'].toString(),
                        user!.uid,
                        data['likes'],
                      );
                    },
                    icon: data['likes'].contains(user?.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            size: 30,
                          ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("${data['likes'].length} likes")),
                  Container(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      DateFormat.yMMMd().format(
                        data['datePublished'].toDate(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
