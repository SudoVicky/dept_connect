import 'package:dept_connect/data/data_sources/remote/firebase_datasource.dart';
import 'package:dept_connect/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseDataSource firebaseDataSource;

  AuthenticationRepositoryImpl({required this.firebaseDataSource});

  @override
  Future<String?> signIn(String email, String password, String role) {
    return firebaseDataSource.signInWithEmailAndPassword(email, password, role);
  }

  @override
  Future<void> signOut() {
    return firebaseDataSource.signOut();
  }
}
