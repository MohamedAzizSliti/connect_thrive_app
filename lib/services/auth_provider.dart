import 'package:flutter/material.dart';
import 'package:connect_thrive_app/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;
  Map<String, dynamic>? _userProfile;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  Map<String, dynamic>? get userProfile => _userProfile;

  // Initialize auth state when app starts
  Future<void> initAuth() async {
    await loadToken();
    if (_isAuthenticated) {
      await refreshProfile();
    }
  }

  // Load token from secure storage
  Future<void> loadToken() async {
    _token = await AuthService.loadToken();
    _isAuthenticated = _token != null;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final result = await AuthService.login(email, password);

    if (result['success']) {
      _isAuthenticated = true;
      _token = result['data']['access_token'];
      await AuthService.setToken(_token!);
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
      await AuthService.setToken(_token!);
      await loadProfile();
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> loadProfile() async {
    await refreshProfile();
  }

  Future<void> refreshProfile() async {
    if (!_isAuthenticated) return;

    final result = await AuthService.getProfile();
    if (result['success']) {
      dynamic profileData = result['data'];

      // Handle different API response formats
      if (profileData is List) {
        if (profileData.isNotEmpty) {
          _userProfile = profileData[0] as Map<String, dynamic>;
        } else {
          _userProfile = null; // Empty list = no profile
        }
      } else if (profileData is Map<String, dynamic>) {
        _userProfile = profileData;
      } else {
        _userProfile = null; // Unexpected format
      }

      notifyListeners();
    } else {
      // Handle token expiration
      if (result['error']?.contains('Session expired') == true) {
        // Token expired, force logout
        await logout();
        return;
      }

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
        dynamic profileData = result['data'];

        // Handle different API response formats for create profile
        if (profileData is List) {
          if (profileData.isNotEmpty) {
            _userProfile = profileData[0] as Map<String, dynamic>;
          } else {
            _userProfile = null;
          }
        } else if (profileData is Map<String, dynamic>) {
          _userProfile = profileData;
        } else {
          _userProfile = null;
        }

        if (_userProfile != null) {
          await AuthService.saveUserData(_userProfile!);
        }

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
