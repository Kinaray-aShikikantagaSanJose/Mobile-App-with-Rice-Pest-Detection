import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Handles login against the FastAPI backend and persists the session
/// (JWT + refresh token) so the user stays logged in across app restarts.
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  // TODO: replace with the deployed FastAPI base URL (see capstone-deployment skill).
  static const String _baseUrl = 'https://api.example.com';

  static const _storage = FlutterSecureStorage();
  static const _kAccessTokenKey = 'access_token';
  static const _kRefreshTokenKey = 'refresh_token';
  static const _kRoleKey = 'user_role';

  /// Calls POST /auth/login and stores the returned tokens on success.
  /// Throws an [AuthException] on invalid credentials or network failure.
  Future<void> login({required String email, required String password}) async {
    final Uri url = Uri.parse('$_baseUrl/auth/login');
    late final http.Response response;
    try {
      response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
    } catch (_) {
      throw AuthException('Could not reach the server. Check your connection.');
    }

    if (response.statusCode != 200) {
      throw AuthException('Invalid email or password.');
    }

    final Map<String, dynamic> body =
        jsonDecode(response.body) as Map<String, dynamic>;
    final String? accessToken = body['access_token'] as String?;
    final String? refreshToken = body['refresh_token'] as String?;
    final String? role = body['role'] as String?;

    if (accessToken == null) {
      throw AuthException('Unexpected response from server.');
    }

    await _storage.write(key: _kAccessTokenKey, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _kRefreshTokenKey, value: refreshToken);
    }
    if (role != null) {
      await _storage.write(key: _kRoleKey, value: role);
    }
  }

  /// True if a stored access token exists — used on app launch to decide
  /// whether to skip splash/login and go straight to home.
  Future<bool> isLoggedIn() async {
    final String? token = await _storage.read(key: _kAccessTokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<String?> getToken() => _storage.read(key: _kAccessTokenKey);

  Future<String?> getRole() => _storage.read(key: _kRoleKey);

  /// Clears the stored session (used by Settings → Log Out).
  Future<void> logout() async {
    await _storage.delete(key: _kAccessTokenKey);
    await _storage.delete(key: _kRefreshTokenKey);
    await _storage.delete(key: _kRoleKey);
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}
