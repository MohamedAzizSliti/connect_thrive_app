import 'package:flutter/material.dart';
import 'package:connect_thrive_app/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;
  Map<String, dynamic>? _userProfile;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  Map<String, dynamic>? get userProfile => _userProfile;

  Future<bool> login(String email, String password) async {
    final result = await AuthService.login(email, password);

    if (result['success']) {
      _isAuthenticated = true;
      _token = result['data']['access_token'];
      await loadProfile();
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> register(String email, String password) async {
    final result = await AuthService.register(email, password);

    if (result['success']) {
      _isAuthenticated = true;
      _token = result['data']['access_token'];
      await loadProfile();
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> loadProfile() async {
    if (!_isAuthenticated) return;

    final result = await AuthService.getProfile();
    if (result['success']) {
      _userProfile = result['data'];
      notifyListeners();
    } else {
      // Profile doesn't exist yet - this is expected for new users
      print('Profile not found: ${result['error']}');
      _userProfile = null;
      notifyListeners();
    }
  }

  Future<bool> updateProfile({String? name, String? imagePath}) async {
    if (!_isAuthenticated) return false;

    final result = await AuthService.updateProfile(
      name: name,
      imagePath: imagePath,
    );

    if (result['success']) {
      _userProfile = result['data'];
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>> createProfile({
    required String name,
    String? imagePath,
  }) async {
    try {
      final result = await AuthService.createProfile(
        name: name,
        imagePath: imagePath,
      );

      if (result['success']) {
        _userProfile = result['data'];
        await AuthService.saveUserData(_userProfile!);
        notifyListeners();
      }

      return result;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to create profile: ${e.toString()}',
      };
    }
  }

  Future<void> logout() async {
    _token = null;
    _userProfile = null;
    _isAuthenticated = false;
    await AuthService.clearAll();
    notifyListeners();
  }

  void setGuestMode() {
    _isAuthenticated = false;
    _token = null;
    _userProfile = null;
    AuthService.clearToken();
    notifyListeners();
  }
}
