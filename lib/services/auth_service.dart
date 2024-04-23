import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> facultyLogin(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // String authenticatedUserEmail = credential.user!.email!;

      // QuerySnapshot hodSnapshot = await _firestore
      //     .collection('faculty')
      //     .where('role', isEqualTo: 'HOD')
      //     .where('email', isEqualTo: authenticatedUserEmail)
      //     .get();

      // if (hodSnapshot.docs.isNotEmpty) {
      //   print("User is hod");
      //   return true;
      // } else {
      //   return false;
      // }
      return true;
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'user-not-found') {
      //     print("No user found for that email.");
      //   } else if (e.code == 'invalid-email') {
      //     print("Invalid email format.");
      //   } else if (e.code == 'wrong-password') {
      //     print("Wrong password.");
      //   } else {
      //     print("Error: $e");
      //   }
      //   return false;
    } catch (e) {
      print("Faculty login error: $e");
      return false; // Return false if login fails
    }
  }
}
