import 'package:cloud_firestore/cloud_firestore.dart';

class Userr {
  final String avatarUrl;
  final String uid;
  final String username;
  final String firstName;
  final String lastName;
  // final String addresss;

  const Userr({
    required this.username,
    required this.uid,
    required this.avatarUrl,
    required this.firstName,
    required this.lastName,
    //required this.addresss,
  });

  static Userr fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print('snapshot ======= $snapshot');
    return Userr(
        username: snapshot["username"],
        uid: snapshot["uid"],
        avatarUrl: snapshot["avatarUrl"],
        firstName: snapshot['firstName'],
        lastName: snapshot['lastName']
        // addresss: snapshot['addresss']
        );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "avatarUrl": avatarUrl,
        "firstName": firstName,
        "lastName": lastName,
      };
}
