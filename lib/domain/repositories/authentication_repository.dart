abstract class AuthenticationRepository {
  Future<String?> signIn(String email, String password, String role);
  Future<void> signOut();
}
