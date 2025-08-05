import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'auth_provider.dart';

class AnalyticsService {
  static const String baseUrl = 'https://connect-nu-lyart.vercel.app/api';

  static Future<String?> _getToken(BuildContext? context) async {
    if (context == null) return null;
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      return authProvider.token;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> getMoodTrends({
    int days = 30,
    BuildContext? context,
  }) async {
    try {
      final token = await _getToken(context);
      if (token == null) throw Exception('No authentication token');

      final response = await http.get(
        Uri.parse('$baseUrl/analytics/mood-trends?days=$days'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        // Mock data for development when endpoint doesn't exist
        return {
          "period": "week",
          "average_mood": 7.5,
          "trend_direction": "improving",
          "entries_count": 5,
          "date_range": {
            "start": "2024-01-01T00:00:00Z",
            "end": "2024-01-07T23:59:59Z",
          },
        };
      } else {
        throw Exception('Failed to load mood trends: ${response.statusCode}');
      }
    } catch (e) {
      print('Analytics fallback: Using mock data for mood trends');
      // Mock data for development
      return {
        "period": "week",
        "average_mood": 7.5,
        "trend_direction": "improving",
        "entries_count": 5,
        "date_range": {
          "start": "2024-01-01T00:00:00Z",
          "end": "2024-01-07T23:59:59Z",
        },
      };
    }
  }

  static Future<Map<String, dynamic>> getContentCorrelation({
    BuildContext? context,
  }) async {
    try {
      final token = await _getToken(context);
      if (token == null) throw Exception('No authentication token');

      final response = await http.get(
        Uri.parse('$baseUrl/analytics/content-correlation'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        // Mock data for development when endpoint doesn't exist
        return {
          "correlation_score": 0.75,
          "positive_words_correlation": 0.82,
          "negative_words_correlation": -0.68,
          "entry_length_correlation": 0.12,
          "sample_size": 25,
        };
      } else {
        throw Exception(
          'Failed to load content correlation: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Analytics fallback: Using mock data for content correlation');
      // Mock data for development
      return {
        "correlation_score": 0.75,
        "positive_words_correlation": 0.82,
        "negative_words_correlation": -0.68,
        "entry_length_correlation": 0.12,
        "sample_size": 25,
      };
    }
  }

  static Future<List<dynamic>> getMoodByTags({BuildContext? context}) async {
    try {
      final token = await _getToken(context);
      if (token == null) throw Exception('No authentication token');

      final response = await http.get(
        Uri.parse('$baseUrl/analytics/mood-by-tags'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        // Mock data for development when endpoint doesn't exist
        return [
          {
            "tag": "family",
            "average_mood": 8.1,
            "entries_count": 8,
            "mood_distribution": {"7": 1, "8": 3, "9": 2, "10": 2},
          },
          {
            "tag": "work",
            "average_mood": 5.2,
            "entries_count": 12,
            "mood_distribution": {"3": 1, "4": 2, "5": 4, "6": 3, "7": 2},
          },
        ];
      } else {
        throw Exception('Failed to load mood by tags: ${response.statusCode}');
      }
    } catch (e) {
      print('Analytics fallback: Using mock data for mood by tags');
      // Mock data for development
      return [
        {
          "tag": "family",
          "average_mood": 8.1,
          "entries_count": 8,
          "mood_distribution": {"7": 1, "8": 3, "9": 2, "10": 2},
        },
        {
          "tag": "work",
          "average_mood": 5.2,
          "entries_count": 12,
          "mood_distribution": {"3": 1, "4": 2, "5": 4, "6": 3, "7": 2},
        },
      ];
    }
  }
}
