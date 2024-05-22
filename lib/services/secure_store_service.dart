import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Keys for storing authentication data
  static const String emailKey = 'email';
  static const String userKey = 'user';
  static const String departmentKey = 'department';

  // Store user authentication data
  Future<void> saveUserData({
    required String email,
    required String user,
    required String department,
  }) async {
    await _secureStorage.write(key: emailKey, value: email);
    await _secureStorage.write(key: userKey, value: user);
    await _secureStorage.write(key: departmentKey, value: department);
  }

  // Retrieve user authentication data
  Future<Map<String, String>?> getUserData() async {
    final email = await _secureStorage.read(key: emailKey);
    final user = await _secureStorage.read(key: userKey);
    final department = await _secureStorage.read(key: departmentKey);

    if (email != null && user != null && department != null) {
      return {
        emailKey: email,
        userKey: user,
        departmentKey: department,
      };
    } else {
      return null; // Return null if any data is missing
    }
  }

  // Delete user authentication data (logout)
  Future<void> deleteUserData() async {
    await _secureStorage.delete(key: emailKey);
    await _secureStorage.delete(key: userKey);
    await _secureStorage.delete(key: departmentKey);
  }
}
