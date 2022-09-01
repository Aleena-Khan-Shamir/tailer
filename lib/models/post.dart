import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  // final String description;
  final String uid;
  final String username;
  //final String address;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String avatarUrl;
  String? imageUrl;
  String? videoUrl;
  final String type;
  Post({
    //required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.avatarUrl,
    required this.imageUrl,
    required this.videoUrl,
    required this.type,
  });

  factory Post.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      //   description: snapshot["description"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      avatarUrl: snapshot['avatarUrl'],
      imageUrl: snapshot['imageUrl'],
      videoUrl: snapshot['videoUrl'],
      type: snapshot['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        //   "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'avatarUrl': avatarUrl,
        'imageUrl': imageUrl,
        'videoUrl': videoUrl,
        'type': type,
      };
}
