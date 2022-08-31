import 'dart:io';
import 'package:alma_app/firebase_services/firestoremethod.dart';
import 'package:alma_app/models/user.dart';
import 'package:alma_app/constant.dart';
import 'package:alma_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PhotoPreviewScreen extends StatefulWidget {
  const PhotoPreviewScreen({Key? key}) : super(key: key);
  static String routeName = '/photo';

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  bool _isLoading = false;

  File? _photo;
  void clearImage() {
    setState(() {
      _photo = null;
    });
  }

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
                    getImages(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.account_box, color: kPrimaryColor),
                ),
                Divider(height: 1.h, color: kPrimaryColor),
                ListTile(
                  title: const Text("Camera"),
                  onTap: () {
                    getImages(ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera, color: kPrimaryColor),
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

  Future getImages(ImageSource source) async {
    final pickedFile = (await ImagePicker().pickImage(source: source));
    if (pickedFile == null) return;
    setState(() {
      _photo = File(pickedFile.path);
    });

    Navigator.pop(context);
  }

  postImage(
    String uid,
    String username,
    String avatarUrl,
    //String address,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_photo == null) {
        print('photo is null ');
        return;
      }
      String res = await FirestoreMethod().uploadPost(
        uid: uid,
        file: _photo!,
        username: username,
        avatarUrl: avatarUrl,
        // address: address,
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
    return _photo == null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor)),
                    onPressed: () {
                      // is button press karne par error ata hai?
                      //
                      _showChoiceDialog(context);
                    },
                    child: const Text('Select image')),
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
                      postImage(
                        user.uid,
                        user.username,
                        user.avatarUrl,
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
                _isLoading ? LinearProgressIndicator() : Container(),
                Container(
                  height: 500.h,
                  width: double.infinity,
                  child: Image.file(_photo!),
                ),
              ],
            )),
          );
  }
}
