import 'package:agrisync/model/comment.dart';
import 'package:agrisync/model/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class AgriConnectService {
  AgriConnectService._();
  static final AgriConnectService instance = AgriConnectService._();

  final _firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

// 1. upload thread
  Future<String?> uploadThread(String photoUrl, String description) async {
    try {
      String threadId = const Uuid().v4();
      DateTime currentTime = DateTime.now();

      Thread thread = Thread(
        threadId: threadId,
        uid: uid,
        photoUrl: photoUrl,
        description: description,
        like: [],
        save: [],
        uploadAt: currentTime,
      );
      _firestore.collection("Thread").doc(thread.threadId).set(thread.toJson());
      return null;
    } catch (e) {
      // print(e);
      return e.toString();
    }
  }

  // User all threads
  Future<List<Thread>> getAllThreads() async {
    final data = await FirebaseFirestore.instance.collection("Thread").get();
    final list = data.docs.map(Thread.fromSnap).toList();

    List<Thread> threads = [];
    // Get Profile Photo
    for (var thread in list) {
      try {
        final user = await getUser(thread.uid);
        thread.userProfilePic = (user['profilePic'] as String?) ?? "";
      } catch (_) {}
      threads.add(thread);
    }

    return threads;
  }

// 2. getThread detail for the future
  Future<Thread?> getThread(String threadId) async {
    try {
      final snap = await _firestore.collection("Thread").doc(threadId).get();
      return Thread.fromSnap(snap);
    } catch (e) {
      return null;
    }
  }

// 3. get the detail for the perticular user
  Future<Map<String, dynamic>> getUser(String uid) async {
    final snap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map<String, dynamic> user = snap.data() as Map<String, dynamic>;
    return user;
  }

// upload the comment
  Future<String?> uploadComment(String threadId, String comment) async {
    try {
      String commentId = const Uuid().v4();
      Comment commentObject =
          Comment(commentId: commentId, comment: comment, like: [], uid: uid);
      await _firestore
          .collection("Thread")
          .doc(threadId)
          .collection("Comments")
          .doc(commentId)
          .set(commentObject.toJson());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

// check thread id like or not
  Future<bool> isLike(String threadId) async {
    final snap = await _firestore.collection("Thread").doc(threadId).get();
    List<String> like = List<String>.from(snap['like'] ?? []);
    if (like.contains(uid)) {
      return true;
    } else {
      return false;
    }
  }

// check the thread is saved or not
  Future<bool> isSaved(String threadId) async {
    final snap = await _firestore.collection("Thread").doc(threadId).get();
    List<String> save = List<String>.from(snap['save'] ?? []);
    if (save.contains(uid)) {
      return true;
    } else {
      return false;
    }
  }

  // save Thread
  Future<String?> savedThread(String threadId) async {
    try {
      final snap = await _firestore.collection("Thread").doc(threadId).get();
      List<String> save = List<String>.from(snap['save'] ?? []);

      if (save.contains(uid)) {
        save.remove(uid);
      } else {
        save.add(uid);
      }
      await _firestore
          .collection("Thread")
          .doc(threadId)
          .update({'save': save});
      return null;
    } catch (e) {
      return e.toString();
    }
  }

// like the thread
  Future<String?> likeThread(String threadId) async {
    try {
      final snap = await _firestore.collection("Thread").doc(threadId).get();
      List<String> like = List<String>.from(snap['like'] ?? []);
      print(like);
      if (like.contains(uid)) {
        like.remove(uid);
      } else {
        like.add(uid);
      }
      await _firestore
          .collection("Thread")
          .doc(threadId)
          .update({'like': like});
      return null;
    } catch (e) {
      return e.toString();
    }
  }

// check the comment is like or not
  Future<bool> isCommentLike(String commentId, String threadId) async {
    DocumentSnapshot snap = await _firestore
        .collection("Thread")
        .doc(threadId)
        .collection("Comments")
        .doc(commentId)
        .get();
    List<String> like = List<String>.from(snap['like'] ?? []);
    return like.contains(uid) ? true : false;
  }

// delete thread
  Future<String?> deleteThread(String threadId, String userId) async {
    try {
      if (uid == userId) {
        await _firestore
            .collection("Thread")
            .doc(threadId)
            .collection("Comments")
            .doc()
            .delete();
        await _firestore.collection("Thread").doc(threadId).delete();

        return null;
      } else {
        return "";
      }
    } catch (e) {
      return e.toString();
    }
  }

// like the comment
  Future<String?> likeComment(String commentId, String threadId) async {
    try {
      DocumentSnapshot snap = await _firestore
          .collection("Thread")
          .doc(threadId)
          .collection("Comments")
          .doc(commentId)
          .get();

      List<String> like = List<String>.from(snap['like'] ?? []);
      if (like.contains(uid)) {
        like.remove(uid);
      } else {
        like.add(uid);
      }
      await _firestore
          .collection("Thread")
          .doc(threadId)
          .collection("Comments")
          .doc(commentId)
          .update({'like': like});
      return null;
    } catch (e) {
      return e.toString();
    }
  }

// delete the comment
  Future<String?> deleteComment(
      String commentId, String threadId, String user2) async {
    try {
      if (user2 == uid) {
        await _firestore
            .collection("Thread")
            .doc(threadId)
            .collection("Comments")
            .doc(commentId)
            .delete();
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
