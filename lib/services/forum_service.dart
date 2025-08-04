import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connect_thrive_app/services/auth_service.dart';

class ForumService {
  static String get baseUrl => 'https://connect-nu-lyart.vercel.app/api';

  static Map<String, String> get authHeaders {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AuthService.token}',
    };
  }

  // Get all forums
  static Future<Map<String, dynamic>> getAllForums() async {
    try {
      print('Fetching forums...');
      print('Headers: $authHeaders');

      final response = await http.get(
        Uri.parse('$baseUrl/forum'),
        headers: authHeaders,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data['data'] ?? []};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to load forums',
        };
      }
    } catch (e) {
      print('Error fetching forums: $e');
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Get user's joined forums
  static Future<Map<String, dynamic>> getMyForums() async {
    try {
      print('Fetching my forums...');

      final response = await http.get(
        Uri.parse('$baseUrl/forum/my'),
        headers: authHeaders,
      );

      print('My forums response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message'] == 'No forums found') {
          return {'success': true, 'data': []};
        }
        return {'success': true, 'data': data['data'] ?? []};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to load my forums',
        };
      }
    } catch (e) {
      print('Error fetching my forums: $e');
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Create new forum
  static Future<Map<String, dynamic>> createForum({
    required String title,
    required String description,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forum'),
        headers: authHeaders,
        body: jsonEncode({'title': title, 'description': description}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Forum created successfully',
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to create forum',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Join or leave forum
  static Future<Map<String, dynamic>> joinLeaveForum({
    required String forumId,
    required String action, // 'join' or 'leave'
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/forum'),
        headers: authHeaders,
        body: jsonEncode({'forumId': forumId, 'action': action}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Action successful',
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to perform action',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Get posts from specific forum
  static Future<Map<String, dynamic>> getForumPosts(String forumId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/forum/posts?forumId=$forumId'),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data['data'] ?? []};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to load posts',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Create new post
  static Future<Map<String, dynamic>> createPost({
    required String forumId,
    required String title,
    required String content,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forum/posts'),
        headers: authHeaders,
        body: jsonEncode({
          'forumId': forumId,
          'title': title,
          'content': content,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Post created successfully',
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to create post',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Delete post
  static Future<Map<String, dynamic>> deletePost(String postId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/forum/posts?postId=$postId'),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Post deleted successfully',
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to delete post',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Create reply
  static Future<Map<String, dynamic>> createReply({
    required String postId,
    required String content,
    String? parentReplyId,
  }) async {
    try {
      final body = {'postId': postId, 'content': content};

      if (parentReplyId != null) {
        body['parentReplyId'] = parentReplyId;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/forum/posts/reply'),
        headers: authHeaders,
        body: jsonEncode(body),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Reply created successfully',
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to create reply',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }

  // Get replies for post
  static Future<Map<String, dynamic>> getPostReplies(String postId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/forum/posts/$postId/replies'),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['message'] ?? 'Failed to load replies',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }
}
