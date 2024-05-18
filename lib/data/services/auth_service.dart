import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> facultyLogin(
      String email, String password, String user) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String authenticatedUserEmail = credential.user!.email!;
      if (user == "HOD") {
        QuerySnapshot hodSnapshot = await _firestore
            .collection('faculty')
            .where('role', isEqualTo: 'HOD')
            .where('email', isEqualTo: authenticatedUserEmail)
            .get();

        if (hodSnapshot.docs.isNotEmpty) {
          return null; // Successful login
        } else {
          return "User not found in faculty collection.";
        }
      } else {
        // Implement other roles if needed
        return "Invalid user type";
      }
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    } catch (e) {
      return "An unexpected error occurred";
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return "No user found for that email.";
      case 'invalid-email':
        return "Invalid email format.";
      case 'wrong-password':
        return "Wrong password.";
      default:
        return "Error: ${e.message}";
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Handle logout error
    }
  }
}
