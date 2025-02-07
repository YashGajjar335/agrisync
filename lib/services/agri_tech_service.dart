import 'package:agrisync/model/comment.dart';
import 'package:agrisync/model/technology.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class AgriTechService {
  AgriTechService._();
  static final AgriTechService instance = AgriTechService._();

  final _firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final String collection = "Technology";
  final String commentCollection = "Comments";

// upload technology
  Future<String?> uploadTechnology(
      String title, String description, String imageUrl) async {
    try {
      String techId = const Uuid().v4();
      DateTime uploadTime = DateTime.now();

      Technology technology = Technology(
          techId: techId,
          uid: uid,
          photoUrl: imageUrl,
          description: description,
          like: [],
          uploadAt: uploadTime,
          save: [],
          title: title);

      await _firestore
          .collection(collection)
          .doc(techId)
          .set(technology.toJson());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

// get user
  Future<Map<String, dynamic>> getUser(String uid) async {
    final snap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map<String, dynamic> user = snap.data() as Map<String, dynamic>;
    return user;
  }

// get technology detail
  Future<Technology?> getTechnology(String techId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection(collection).doc(techId).get();
      return Technology.fromSnap(snap);
    } catch (e) {
      return null;
    }
  }

// delete technology
  Future<String?> deleteTechnology(String techId, String userId) async {
    try {
      if (uid == userId) {
        await _firestore
            .collection(collection)
            .doc(techId)
            .collection(commentCollection)
            .doc()
            .delete();
        await _firestore.collection(collection).doc(techId).delete();
        return null;
      } else {
        return "Unauthorized to delete";
      }
    } catch (e) {
      return e.toString();
    }
  }

// save technology
  Future<String?> saveTechnology(String techId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection(collection).doc(techId).get();
      List<String> saves = List<String>.from(snap["save"] ?? []);

      if (saves.contains(uid)) {
        saves.remove(uid);
      } else {
        saves.add(uid);
      }

      await _firestore
          .collection(collection)
          .doc(techId)
          .update({"save": saves});
      return null;
    } catch (e) {
      return e.toString();
    }
  }

// upload comment
  Future<String?> uploadComment(String techId, String comment) async {
    try {
      String commentId = const Uuid().v4();
      Comment commentObject =
          Comment(commentId: commentId, comment: comment, like: [], uid: uid);
      await _firestore
          .collection(collection)
          .doc(techId)
          .collection(commentCollection)
          .doc(commentId)
          .set(commentObject.toJson());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

// check thread id like or not
  Future<bool> isLike(String techId) async {
    final snap = await _firestore.collection(collection).doc(techId).get();
    List<String> like = List<String>.from(snap['like'] ?? []);
    if (like.contains(uid)) {
      return true;
    } else {
      return false;
    }
  }

// check the thread is saved or not
  Future<bool> isSaved(String techId) async {
    final snap = await _firestore.collection(collection).doc(techId).get();
    List<String> save = List<String>.from(snap['save'] ?? []);
    if (save.contains(uid)) {
      return true;
    } else {
      return false;
    }
  }

// like the thread
  Future<String?> likeTechnology(String techId) async {
    try {
      final snap = await _firestore.collection(collection).doc(techId).get();
      List<String> like = List<String>.from(snap['like'] ?? []);
      print(like);
      if (like.contains(uid)) {
        like.remove(uid);
      } else {
        like.add(uid);
      }
      await _firestore
          .collection(collection)
          .doc(techId)
          .update({'like': like});
      return null;
    } catch (e) {
      return e.toString();
    }
  }

// check the comment is like or not
  Future<bool> isCommentLike(String commentId, String techId) async {
    DocumentSnapshot snap = await _firestore
        .collection(collection)
        .doc(techId)
        .collection(commentCollection)
        .doc(commentId)
        .get();
    List<String> like = List<String>.from(snap['like'] ?? []);
    return like.contains(uid) ? true : false;
  }

// like the comment
  Future<String?> likeComment(String commentId, String techId) async {
    try {
      DocumentSnapshot snap = await _firestore
          .collection(collection)
          .doc(techId)
          .collection(commentCollection)
          .doc(commentId)
          .get();

      List<String> like = List<String>.from(snap['like'] ?? []);
      if (like.contains(uid)) {
        like.remove(uid);
      } else {
        like.add(uid);
      }
      await _firestore
          .collection(collection)
          .doc(techId)
          .collection(commentCollection)
          .doc(commentId)
          .update({'like': like});
      return null;
    } catch (e) {
      return e.toString();
    }
  }

// delete the comment
  Future<String?> deleteComment(
      String commentId, String techId, String user2) async {
    try {
      if (user2 == uid) {
        await _firestore
            .collection(collection)
            .doc(techId)
            .collection(commentCollection)
            .doc(commentId)
            .delete();
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
