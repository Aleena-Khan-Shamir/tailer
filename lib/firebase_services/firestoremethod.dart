import 'dart:io';

import 'package:alma_app/firebase_services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FirestoreMethod {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //upload post
  Future<String> uploadPost({
    required String uid,
    required File file,
    // String description,
    required String username,
    required String avatarUrl,
    // required String address,
  }) async {
    String res = 'some error occured';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('post', file, true);
      //It gives the unique identity

      String postId = const Uuid().v1();
      Post post = Post(
        //   description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        imageUrl: photoUrl,
        videoUrl: photoUrl,
        avatarUrl: avatarUrl,
      );
      _firestore.collection('post').doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//Like Post
  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('post').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('post').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  static Future getPost() async {
    return await _firestore
        .collection('post')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return _firestore.collection('post').snapshots();
  }

  static Future<void> deletePost(String postId) async {
    try {
      return await _firestore.collection('post').doc(postId).delete();
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
