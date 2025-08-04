import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String baseUrl = 'https://connect-nu-lyart.vercel.app/api';
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Store the JWT token
  static String? _token;

  static String? get token => _token;

  static Future<void> setToken(String token) async {
    _token = token;
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  static Future<void> clearToken() async {
    _token = null;
    await _secureStorage.delete(key: 'auth_token');
  }

  // Load token from secure storage
  static Future<String?> loadToken() async {
    try {
      _token = await _secureStorage.read(key: 'auth_token');
      return _token;
    } catch (e) {
      print('Error loading token: $e');
      return null;
    }
  }

  // Save user data to local storage
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(userData));
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  // Load user data from local storage
  static Future<Map<String, dynamic>?> loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataString = prefs.getString('user_data');
      if (userDataString != null) {
        return jsonDecode(userDataString);
      }
      return null;
    } catch (e) {
      print('Error loading user data: $e');
      return null;
    }
  }

  // Clear all stored data
  static Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _token = null;
    } catch (e) {
      print('Error clearing stored data: $e');
    }
  }

  static Map<String, String> get authHeaders {
    final headers = {'Content-Type': 'application/json'};
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  // Login
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['access_token'];
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(response.body);
        return {'success': false, 'error': error['error'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Register
  static Future<Map<String, dynamic>> register(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['error'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Get profile
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        dynamic profileData = data['profile'];
        if (profileData is List && profileData.isNotEmpty) {
          profileData = profileData[0];
        } else if (profileData is List && profileData.isEmpty) {
          return {'success': false, 'error': 'No profile found'};
        }
        return {'success': true, 'data': profileData};
      } else if (response.statusCode == 401) {
        // Token expired or invalid
        await clearToken();
        return {
          'success': false,
          'error': 'Session expired. Please login again.',
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['error'] ?? 'Failed to load profile',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Create user profile
  static Future<Map<String, dynamic>> createProfile({
    required String name,
    String? imagePath,
  }) async {
    try {
      print('Creating profile with name: $name, imagePath: $imagePath');
      print('Auth headers: $authHeaders');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/profile'),
      );

      // Add authorization header
      request.headers.addAll(authHeaders);
      print('Request headers: ${request.headers}');

      // Add form fields
      request.fields['name'] = name;
      print('Request fields: ${request.fields}');

      // Add image file if provided
      if (imagePath != null) {
        print('Adding image file: $imagePath');
        // Determine the correct content type based on file extension
        String contentType = 'image/jpeg'; // Default
        if (imagePath.toLowerCase().endsWith('.png')) {
          contentType = 'image/png';
        } else if (imagePath.toLowerCase().endsWith('.jpg') ||
            imagePath.toLowerCase().endsWith('.jpeg')) {
          contentType = 'image/jpeg';
        } else if (imagePath.toLowerCase().endsWith('.gif')) {
          contentType = 'image/gif';
        }

        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imagePath,
            contentType: http_parser.MediaType.parse(contentType),
          ),
        );
        print('Image file added successfully with content type: $contentType');
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      final data = jsonDecode(responseBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Profile created successfully: ${data['profile']}');
        return {'success': true, 'data': data['profile']};
      } else {
        final error = data['error'] ?? 'Failed to create profile';
        print('Profile creation failed: $error');
        return {'success': false, 'error': error};
      }
    } catch (e, stackTrace) {
      print('Error creating profile: $e');
      print('Stack trace: $stackTrace');
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Create/update profile
  static Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? imagePath,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/profile'),
      );
      request.headers.addAll(authHeaders);

      if (name != null) {
        request.fields['name'] = name;
      }

      if (imagePath != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imagePath),
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(responseBody);
        return {
          'success': false,
          'error': error['error'] ?? 'Failed to update profile',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }
}
