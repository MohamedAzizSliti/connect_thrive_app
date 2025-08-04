import 'package:flutter/material.dart';
import 'package:connect_thrive_app/services/forum_service.dart';
import 'package:connect_thrive_app/models/forum_models.dart';

class ForumProvider extends ChangeNotifier {
  List<Forum> _allForums = [];
  List<Forum> _myForums = [];
  List<ForumPost> _currentForumPosts = [];
  List<ForumReply> _currentPostReplies = [];
  bool _isLoading = false;
  String? _error;

  List<Forum> get allForums => _allForums;
  List<Forum> get myForums => _myForums;
  List<ForumPost> get currentForumPosts => _currentForumPosts;
  List<ForumReply> get currentPostReplies => _currentPostReplies;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load all forums
  Future<void> loadAllForums() async {
    _setLoading(true);
    _clearError();

    try {
      final result = await ForumService.getAllForums();
      if (result['success']) {
        final forumsData = result['data'] as List;
        _allForums = forumsData.map((json) => Forum.fromJson(json)).toList();
        print('Loaded ${_allForums.length} forums');
      } else {
        _setError(result['error']);
        print('Error loading forums: ${result["error"]}');
      }
    } catch (e) {
      _setError('Failed to load forums: $e');
      print('Exception loading forums: $e');
    }

    _setLoading(false);
  }

  // Load user's joined forums
  Future<void> loadMyForums() async {
    _setLoading(true);
    _clearError();

    try {
      final result = await ForumService.getMyForums();
      if (result['success']) {
        final forumsData = result['data'] as List;
        _myForums =
            forumsData.map((json) {
              try {
                // Handle both full forum objects and just forum IDs
                if (json is Map<String, dynamic> && json.containsKey('id')) {
                  return Forum.fromJson(json);
                } else if (json is Map<String, dynamic> &&
                    json.containsKey('forum_id')) {
                  return Forum(
                    id: json['forum_id'],
                    title: json['title'] ?? 'Forum',
                    description:
                        json['description'] ??
                        'Welcome to our community forum! This is a place for meaningful discussions, sharing ideas, and connecting with like-minded individuals. Feel free to start new conversations, ask questions, and engage with other members of our community.',
                    createdBy: json['created_by'] ?? '',
                    createdAt: DateTime.parse(
                      json['created_at'] ?? DateTime.now().toIso8601String(),
                    ),
                    updatedAt: DateTime.parse(
                      json['updated_at'] ?? DateTime.now().toIso8601String(),
                    ),
                    isActive: json['is_active'] ?? true,
                    isMember:
                        json['is_member'] ??
                        false, // User is member of their own forums
                  );
                }
                return Forum(
                  id: json.toString(),
                  title: 'Community Forum',
                  description:
                      'Join our vibrant community where ideas flourish and connections grow. This forum is designed to foster meaningful discussions, share valuable insights, and build lasting relationships among members who share common interests and goals.',
                  createdBy: 'System',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  isActive: true,
                  isMember: true,
                );
              } catch (e) {
                print('Error parsing forum: $e, json: $json');
                return Forum(
                  id: 'error',
                  title: 'Error',
                  description: 'Failed to parse forum',
                  createdBy: '',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  isActive: false,
                  isMember: false,
                );
              }
            }).toList();
        print('Loaded ${_myForums.length} my forums');
      } else {
        _setError(result['error']);
        print('Error loading my forums: ${result["error"]}');
      }
    } catch (e) {
      _setError('Failed to load my forums: $e');
      print('Exception loading my forums: $e');
    }

    _setLoading(false);
  }

  // Create new forum
  Future<bool> createForum({
    required String title,
    required String description,
  }) async {
    _setLoading(true);
    _clearError();

    final result = await ForumService.createForum(
      title: title,
      description: description,
    );

    if (result['success']) {
      await loadAllForums();
      await loadMyForums();
      _setLoading(false);
      return true;
    } else {
      _setError(result['error']);
      _setLoading(false);
      return false;
    }
  }

  // Join or leave forum
  Future<bool> joinLeaveForum({
    required String forumId,
    required String action,
  }) async {
    _setLoading(true);
    _clearError();

    final result = await ForumService.joinLeaveForum(
      forumId: forumId,
      action: action,
    );

    if (result['success']) {
      // Refresh both my forums and all forums to ensure UI updates
      await Future.wait([
        loadMyForums(),
        loadAllForums(),
      ]);
      _setLoading(false);
      return true;
    } else {
      _setError(result['error']);
      _setLoading(false);
      return false;
    }
  }

  // Load posts from specific forum
  Future<void> loadForumPosts(String forumId) async {
    _setLoading(true);
    _clearError();

    final result = await ForumService.getForumPosts(forumId);
    if (result['success']) {
      final postsData = result['data'] as List;
      _currentForumPosts =
          postsData.map((json) => ForumPost.fromJson(json)).toList();
    } else {
      _setError(result['error']);
      _currentForumPosts = [];
    }

    _setLoading(false);
  }

  // Create new post
  Future<bool> createPost({
    required String forumId,
    required String title,
    required String content,
  }) async {
    _setLoading(true);
    _clearError();

    final result = await ForumService.createPost(
      forumId: forumId,
      title: title,
      content: content,
    );

    if (result['success']) {
      await loadForumPosts(forumId);
      _setLoading(false);
      return true;
    } else {
      _setError(result['error']);
      _setLoading(false);
      return false;
    }
  }

  // Delete post
  Future<bool> deletePost(String postId) async {
    _setLoading(true);
    _clearError();

    final result = await ForumService.deletePost(postId);

    if (result['success']) {
      _setLoading(false);
      return true;
    } else {
      _setError(result['error']);
      _setLoading(false);
      return false;
    }
  }

  // Create reply
  Future<bool> createReply({
    required String postId,
    required String content,
    String? parentReplyId,
  }) async {
    _setLoading(true);
    _clearError();

    final result = await ForumService.createReply(
      postId: postId,
      content: content,
      parentReplyId: parentReplyId,
    );

    if (result['success']) {
      await loadPostReplies(postId);
      _setLoading(false);
      return true;
    } else {
      _setError(result['error']);
      _setLoading(false);
      return false;
    }
  }

  // Load replies for specific post
  Future<void> loadPostReplies(String postId) async {
    _setLoading(true);
    _clearError();

    final result = await ForumService.getPostReplies(postId);
    if (result['success']) {
      final repliesData = result['data'] as List;
      _currentPostReplies =
          repliesData.map((json) => ForumReply.fromJson(json)).toList();
    } else {
      _setError(result['error']);
      _currentPostReplies = [];
    }

    _setLoading(false);
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  void clearCurrentData() {
    _currentForumPosts = [];
    _currentPostReplies = [];
    _clearError();
    notifyListeners();
  }
}
