import 'package:flutter/material.dart';
import '../models/journal_models.dart';
import 'journal_service.dart';

class JournalProvider extends ChangeNotifier {
  List<JournalEntry> _journalEntries = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasMore = true;

  // Getters
  List<JournalEntry> get journalEntries => _journalEntries;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get hasMore => _hasMore;

  // Private methods
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
    notifyListeners();
  }

  // Load journal entries with pagination
  Future<void> loadJournalEntries({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _journalEntries.clear();
    }

    if (!_hasMore && !refresh) return;

    _setLoading(true);
    _clearError();

    try {
      final result = await JournalService.getJournalEntries(
        page: _currentPage,
        limit: 10,
      );

      if (result['success']) {
        final List<dynamic> data = result['data'];
        final newEntries = data.map((e) => JournalEntry.fromJson(e)).toList();

        if (refresh) {
          _journalEntries = newEntries;
        } else {
          _journalEntries.addAll(newEntries);
        }

        // For now, we'll assume pagination based on entries count
        // In a real implementation, the API should return pagination info
        if (newEntries.length < 10) {
          _hasMore = false;
        } else {
          _currentPage++;
        }

        notifyListeners();
      } else {
        _setError(result['error']);
      }
    } catch (e) {
      _setError('Failed to load journal entries: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Create new journal entry
  Future<bool> createJournalEntry({
    required String title,
    required String content,
    List<String> tags = const [],
    MoodData? mood,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final entry = JournalEntry(
        id: '', // Will be assigned by API
        title: title,
        content: content,
        tags: tags,
        createdAt: DateTime.now(),
        mood: mood,
      );

      final result = await JournalService.createJournalEntry(entry);

      if (result['success']) {
        // Refresh the journal entries list immediately
        await loadJournalEntries(refresh: true);
        return true;
      } else {
        _setError(result['error']);
        return false;
      }
    } catch (e) {
      _setError('Failed to create journal entry: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update journal entry
  Future<bool> updateJournalEntry(JournalEntry entry) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await JournalService.updateJournalEntry(entry);

      if (result['success']) {
        // Update the local list
        final index = _journalEntries.indexWhere((e) => e.id == entry.id);
        if (index != -1) {
          _journalEntries[index] = entry;
          notifyListeners();
        }
        return true;
      } else {
        _setError(result['error']);
        return false;
      }
    } catch (e) {
      _setError('Failed to update journal entry: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Delete journal entry
  Future<bool> deleteJournalEntry(String id) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await JournalService.deleteJournalEntry(id);

      if (result['success']) {
        // Remove from local list
        _journalEntries.removeWhere((e) => e.id == id);
        notifyListeners();
        return true;
      } else {
        _setError(result['error']);
        return false;
      }
    } catch (e) {
      _setError('Failed to delete journal entry: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Search journal entries
  Future<List<JournalEntry>> searchJournalEntries(String query) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await JournalService.searchJournalEntries(query: query);

      if (result['success']) {
        final List<dynamic> data = result['data'];
        return data.map((e) => JournalEntry.fromJson(e)).toList();
      } else {
        _setError(result['error']);
        return [];
      }
    } catch (e) {
      _setError('Failed to search journal entries: ${e.toString()}');
      return [];
    } finally {
      _setLoading(false);
    }
  }

  // Get specific journal entry
  Future<JournalEntry?> getJournalEntry(String id) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await JournalService.getJournalEntry(id);

      if (result['success']) {
        return JournalEntry.fromJson(result['data']);
      } else {
        _setError(result['error']);
        return null;
      }
    } catch (e) {
      _setError('Failed to load journal entry: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Refresh journal entries
  Future<void> refresh() async {
    await loadJournalEntries(refresh: true);
  }

  // Clear all journal entries (for logout)
  void clear() {
    _journalEntries.clear();
    _currentPage = 1;
    _totalPages = 1;
    _hasMore = true;
    _error = null;
    notifyListeners();
  }
}
