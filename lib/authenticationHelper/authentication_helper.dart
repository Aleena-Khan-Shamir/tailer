import 'dart:io';

import 'package:alma_app/constant.dart';
import 'package:alma_app/firebase_services/storage.dart';
import 'package:alma_app/models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AuthenticationHelper {
  static final FirebaseAuth? auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static File? _imageFile;

// get user details
  Future<model.Userr> getUserDetails() async {
    // print('getUserDetail called');
    User currentUser = FirebaseAuth.instance.currentUser!;

    // print(' ========= userId ${currentUser.uid}');
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('userData')
        .doc(currentUser.uid)
        .get();

    return model.Userr.fromSnap(documentSnapshot);
  }

  static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile', 'user_birthday']);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // final userData = await FacebookAuth.instance.getUserData();
    // final userEmail = userData['email'];

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

//SIGN IN with Google
  static Future<UserCredential> signInWithGoogle() async {
    // Initiate the auth procedure
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();
    // fetch the auth details from the request made earlier
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    // Create a new credential for signing in with google
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

// SIGNOUT with google
  static Future googlSignOut() async {
    // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    final GoogleSignIn googleUser = GoogleSignIn(scopes: <String>["email"]);

    await FirebaseAuth.instance.signOut();
    googleUser.signOut();
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // get user => _auth.currentUser;

  //SIGN UP METHOD
//  static Future<String?> signUp({String email, String password}) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }

//Complete Profile

  static Future<String?> compProfile(
    String firstName,
    String lastName,
    String phoneNumber,
    String address,
    File file,
  ) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    //File? file;
    var downloadUrl =
        await StorageMethods().uploadImageToStorage('profilePics', file, true);
    try {
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(firebaseUser?.uid)
          .set({
        'uid': firebaseUser?.uid,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "address": address,
        'avatarUrl': downloadUrl,
        'username': '$firstName $lastName',
      });
    } on FirebaseException catch (e) {
      return e.toString();
    }
    return null;
  }

  // static Future<String?> getUserInfo() async {
  //  User currentUser=auth!.currentUser!;
  //  DocumentSnapshot snap=await
  // }

  static Future<String?> signUp(String email, String password) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
      // await FirebaseFirestore.instance
      //     .collection('userData')
      //     .doc(firebaseUser!.uid)
      //     .set({'email': email});
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  static Future<String?> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  //SIGN OUT METHOD
  static Future signOut() async {
    await FirebaseAuth.instance.signOut();

    // print('signout');
  }
}
