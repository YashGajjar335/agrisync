import 'package:firebase_auth/firebase_auth.dart';

class AdminLoginService {
  AdminLoginService._();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final AdminLoginService instance = AdminLoginService._();

  Future<String?> loginAdmin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> logOut() async {
    try {
      await _auth.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
