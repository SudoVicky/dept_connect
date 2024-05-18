import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationLoginRequested>(_mapLoginRequestedToState);
    on<AuthenticationLoggedOut>(_mapLoggedOutToState);
  }

  void _mapLoginRequestedToState(
    AuthenticationLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading()); // Emit loading state
    try {
      // Attempt to sign in with email and password
      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      // If successful, emit AuthenticationAuthenticated state
      emit(AuthenticationAuthenticated());
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
    }

    return errorMessage;
  }

  void _mapLoggedOutToState(
    AuthenticationLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) {
    // Log out the user
    _auth.signOut();
    // Emit AuthenticationUnauthenticated state
    emit(AuthenticationUnauthenticated());
  }
}
