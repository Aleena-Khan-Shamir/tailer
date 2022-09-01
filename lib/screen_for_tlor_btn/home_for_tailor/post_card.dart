import 'package:alma_app/firebase_services/firestoremethod.dart';
import 'package:alma_app/screen_for_tlor_btn/home_for_tailor/profile_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class PostCardForTailor extends StatefulWidget {
  final snap;
  const PostCardForTailor({
    Key? key,
    required this.snap,
  }) : super(key: key);
  static String routeName = '/home_for_tailor';

  @override
  State<PostCardForTailor> createState() => _PostCardForTailorState();
}

class _PostCardForTailorState extends State<PostCardForTailor> {
  var userData = {};
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    getData();
    controller = VideoPlayerController.network(widget.snap["videoUrl"])
      ..initialize().then((value) {
        setState(() {
          controller.play();
          controller.setLooping(
            true,
          );
        });
      });
  }

  getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    var userSnap = await FirebaseFirestore.instance
        .collection('userData')
        .doc(user!.uid)
        .get();
    setState(() {
      userData = userSnap.data()!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.snap.data();
    String? fileName;
    //  print(snap["avatarUrl"]);
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 16.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundImage: NetworkImage(
                    // FirebaseAuth.instance.currentUser!.photoURL == null
                    //     ? 'data:image/jpeg;base64,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'
                    //     : FirebaseAuth.instance.currentUser!.photoURL!
                    data['avatarUrl'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            print('Profile Screen');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProfileInfo(
                                          uid: userData['uid'],
                                        )));
                            //  Navigator.pushNamed(context, ProfileInfo.routeName);
                          },
                          child: Text(
                            data['username'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: ListView(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                    onTap: () {
                                      FirestoreMethod.deletePost(
                                          data['postId']);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 13.h, horizontal: 17.w),
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          //Image Section
          SizedBox(
            height: 350.h,
            width: double.infinity,
            child: data['type'] == "image"
                ? Image.network(
                    data['imageUrl'],
                  )
                : controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          ),

          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              DateFormat.yMMMd().format(
                data['datePublished'].toDate(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
