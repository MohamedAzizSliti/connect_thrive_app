import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/journal_models.dart';
import 'auth_service.dart';

class JournalService {
  static const String baseUrl = 'https://connect-nu-lyart.vercel.app/api';

  static Map<String, String> get authHeaders {
    final token = AuthService.token;
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Get paginated journal entries
  static Future<Map<String, dynamic>> getJournalEntries({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/journal?page=$page&limit=$limit'),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to load journal entries',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Get specific journal entry
  static Future<Map<String, dynamic>> getJournalEntry(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/journal/$id'),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to load journal entry',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Create new journal entry
  static Future<Map<String, dynamic>> createJournalEntry(
    JournalEntry entry,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/journal'),
        headers: authHeaders,
        body: jsonEncode(entry.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Journal entry created successfully',
          'data': data,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to create journal entry',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Update journal entry
  static Future<Map<String, dynamic>> updateJournalEntry(
    JournalEntry entry,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/journal/${entry.id}'),
        headers: authHeaders,
        body: jsonEncode(entry.toUpdateJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Journal entry updated successfully',
          'data': data,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to update journal entry',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Delete journal entry
  static Future<Map<String, dynamic>> deleteJournalEntry(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/journal/$id'),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Journal entry deleted successfully',
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to delete journal entry',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Search journal entries with optional query parameter
  static Future<Map<String, dynamic>> searchJournalEntries({
    String query = '',
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final url = Uri.parse(
        '$baseUrl/journal?page=$page&limit=$limit${query.isNotEmpty ? '&search=${Uri.encodeComponent(query)}' : ''}',
      );

      final response = await http.get(url, headers: authHeaders);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to search journal entries',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }
}
