import 'package:agrisync/model/farmer.dart';
import 'package:agrisync/model/specialist.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginServices {
  LoginServices._();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final LoginServices instance = LoginServices._();
// farmer SignUp
  Future<String?> signUpFarmer(
    String email,
    String password,
    String name,
  ) async {
    // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // String uid = const Uuid().v4();
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? uid = auth.currentUser!.uid;

      Farmer user = Farmer(
        uid: uid,
        role: "Farmer",
        profilePic: "",
        uname: name,
        email: email,
        // password: password,
      );
      await _firestore.collection(user.role).doc(user.uid).set(user.toJson());
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        print("email is invalid");
      }
      return e.toString();
    } catch (e) {
      return e.toString();
    }
  }

// Specialist SignUp
  Future<String?> signUpSpecialist(
      String name, String email, String password, String doc) async {
    String? res;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String? uid = auth.currentUser!.uid;

      Specialist specialist = Specialist(
        uid: uid,
        role: "Specialist",
        profilePic: "",
        isVerified: false,
        uname: name,
        email: email,
        // password: password,
        validProof: doc,
      );
      await _firestore
          .collection(specialist.role)
          .doc(specialist.uid)
          .set(specialist.toJson());
      res = null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        res = "The account already exists for that email.";
      }
      res = e.toString();
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

// user Login
  Future<String?> loginUser(String email, String password) async {
    String? res;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      res = null;
    } on FirebaseAuthException catch (e) {
      res = e.toString();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String?> logOut() async {
    try {
      await auth.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.toString();
    } catch (e) {
      return e.toString();
    }
  }

  String forgotPassword(String email) {
    if (email.isNotEmpty) {
      auth.sendPasswordResetEmail(email: email);
      return "Password reset link send in your Email on $email";
    } else if (emailValidator(email)) {
      return "Enter Valid Email";
    } else {
      return "Full fill the email feild first ";
    }
  }
}
