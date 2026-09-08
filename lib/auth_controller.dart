import 'package:flutter/material.dart';

enum AppRole { farmer, technician, agriculturist }

abstract class AuthController extends ChangeNotifier {
  bool get isLoggedIn;
  bool get sessionVerified; 
  AppRole? get role;

  void login();
  void logout();
  void verifySession();
}

class AuthControllerImpl extends AuthController {
  bool _isLoggedIn = true;
  bool _sessionVerified = true;
  AppRole? _role = AppRole.farmer;

  @override
  bool get isLoggedIn => _isLoggedIn;

  @override
  bool get sessionVerified => _sessionVerified;

  @override
  AppRole? get role => _role;

  @override
  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  @override
  void logout() {
    _isLoggedIn = false;
    _sessionVerified = false;
    _role = null;
    notifyListeners();
  }

  @override
  void verifySession() {
    if (_isLoggedIn) {
      _sessionVerified = true;
      _role = AppRole.farmer; // Default for demo
      notifyListeners();
    }
  }
}
