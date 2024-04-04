import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> facultyLogin(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Check if the user is a faculty in your database
      // Perform any additional logic specific to faculty login
      return true; // Return true if login is successful
    } catch (e) {
      print("Faculty login error: $e");
      return false; // Return false if login fails
    }
  }
}
