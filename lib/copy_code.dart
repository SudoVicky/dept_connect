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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Error: ${e.message}');
      }
      return false; // Return false if login fails
    } catch (e) {
      print("Login error: $e");
      return false; // Return false if login fails
    }
  }
}
