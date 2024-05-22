import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dept_connect/services/secure_store_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SecureStorageService _secureStorage = SecureStorageService();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationLoginRequested>(_mapLoginRequestedToState);
    on<AuthenticationLoggedOut>(_mapLoggedOutToState);
    on<AuthenticationLocalLoginRequested>(_mapLocalLoginRequested);
  }

  void _mapLoginRequestedToState(
    AuthenticationLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading()); // Emit loading state
    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Get the email from the user object
      String email = userCredential.user!.email!;
      // If successful, emit AuthenticationAuthenticated state
      // Check if the user role is "HOD"
      if (event.user == "HOD") {
        // Query Firestore to find the user with role "HOD" and the authenticated email
        QuerySnapshot hodSnapshot = await _firestore
            .collection('faculty')
            .where('role', isEqualTo: 'HOD')
            .where('email', isEqualTo: email)
            .get();

        // If a document is found, emit AuthenticationAuthenticated state with email and user information
        if (hodSnapshot.docs.isNotEmpty) {
          var hodData = hodSnapshot.docs.first.data() as Map<String, dynamic>;
          String dept = hodData['department']!;
          emit(AuthenticationAuthenticated(
              email: email, user: event.user, dept: dept));

          await _secureStorage.saveUserData(
            email: email,
            user: event.user,
            department: dept,
          );
        } else {
          // If no document is found, emit AuthenticationFailure state with an error message
          emit(AuthenticationFailure("User not found in faculty collection."));
        }
      } else {
        // For other roles, handle accordingly or return an error message
        emit(AuthenticationFailure("Invalid user type"));
      }
    } catch (error) {
      String errorMessage = _getErrorMessage(error);
      // If there's an error, emit AuthenticationFailure state with a user-friendly error message
      emit(AuthenticationFailure(errorMessage));
    }
  }

  String _getErrorMessage(dynamic error) {
    // Default error message
    String errorMessage = 'An error occurred. Please try again later.';

    // Handle specific FirebaseAuth errors
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email format';
          break;
        case 'invalid-credential':
          errorMessage = 'Incorrect credentials. Please try again.';
          break;
        case 'network-request-failed':
          errorMessage =
              'Network error. Please check your internet connection and try again.';
          break;
        // Add more cases for other FirebaseAuthException codes as needed
        default:
          errorMessage = 'Authentication failed: ${error.code}';
          break;
      }
    } else {
      print("other errors: $error");
    }

    return errorMessage;
  }

  void _mapLocalLoginRequested(
    AuthenticationLocalLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final secureStorage = SecureStorageService();

    final userData = await secureStorage.getUserData();

    if (userData != null) {
      final email = userData[SecureStorageService.emailKey]!;
      final user = userData[SecureStorageService.userKey]!;
      final dept = userData[SecureStorageService.departmentKey]!;
      emit(AuthenticationAuthenticated(email: email, user: user, dept: dept));
    } else {
      emit(AuthenticationInitial());
    }
  }

  void _mapLoggedOutToState(
    AuthenticationLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) {
    // Log out the user
    _auth.signOut();
    // Delete user data from secure storage
    _secureStorage.deleteUserData();

    emit(AuthenticationInitial());
  }
}
