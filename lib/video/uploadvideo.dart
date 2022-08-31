import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../constant.dart';
import '../firebase_services/firestoremethod.dart';
import '../models/user.dart';
import '../provider/user_provider.dart';

class Videoo extends StatefulWidget {
  const Videoo({Key? key}) : super(key: key);
  static String routeName = '/video';
  @override
  State<Videoo> createState() => _VideooState();
}

class _VideooState extends State<Videoo> {
  File? _video;
  VideoPlayerController? _videoPlayerController;
  bool _isLoading = false;
  //bool _isPlaying = false;

  _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose the option'),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                Divider(height: 1.h, color: kPrimaryColor),
                ListTile(
                  title: const Text("Gallery"),
                  onTap: () {
                    _getVideo(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.account_box, color: kPrimaryColor),
                ),
                Divider(height: 1.h, color: kPrimaryColor),
                ListTile(
                  title: const Text("Cancel"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.cancel, color: kPrimaryColor),
                ),
              ],
            )),
          );
        });
  }

  postImage(
    String uid,
    String username,
    String avatarUrl,
   // String address,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_video == null) {
        print('photo is null ');
        return;
      }
      String res = await FirestoreMethod().uploadPost(
          uid: uid,
          file: _video!,
          username: username,
          avatarUrl: avatarUrl,
          //address: address
          //video: _video!,
          );
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted', context);
        // clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      print('errorr $e');
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> _getVideo(ImageSource source) async {
    XFile? video = await ImagePicker().pickVideo(source: source);

    _video = File(video!.path);
    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController!.play();
        });
      });
    //super.initState();
  }

  void clearImage() {
    setState(() {
      _video = null;
    });
  }

  // Widget? videoStatusAnimation;
  // @override
  // void initState() {
  //   videoStatusAnimation = Container();

  //   _videoPlayerController = VideoPlayerController.file(_video!)
  //     ..addListener(() {
  //       final bool isPlaying = _videoPlayerController!.value.isPlaying;
  //       if (isPlaying != _isPlaying) {
  //         setState(() {
  //           _isPlaying = isPlaying;
  //         });
  //       }
  //     })
  //     ..initialize().then((_) {
  //       Timer(Duration(milliseconds: 0), () {
  //         if (!mounted) return;

  //         setState(() {});
  //         _videoPlayerController!.play();
  //       });
  //     });
  //   super.initState();
  // }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Userr? user = Provider.of<UserProvider>(context).getUser;
    if (user == null) {
      print('user is  $user');
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      ));
    }
    return _video == null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor)),
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                    child: const Text('Select video')),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text(
                'Post to',
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      //print('uid:  ${user.uid}');
                      postImage(user.uid, user.username, user.avatarUrl,
                          );
                    },
                    child: Text(
                      'Post',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
                    ))
              ],
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                _isLoading ? const LinearProgressIndicator() : Container(),
                SizedBox(
                  height: 500.h,
                  width: double.infinity,
                  child: _videoPlayerController!.value.isInitialized
                      ? VideoPlayer(_videoPlayerController!)
                      : const Center(child: Text('Loading...')),
                ),
              ],
            )),
          );
  }
}
