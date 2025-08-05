import 'package:flutter/material.dart';
import 'package:connect_thrive_app/services/analytics_service.dart';
import 'package:connect_thrive_app/l10n/app_localizations.dart';

class MoodAnalyticsDashboard extends StatefulWidget {
  const MoodAnalyticsDashboard({super.key});

  @override
  State<MoodAnalyticsDashboard> createState() => _MoodAnalyticsDashboardState();
}

class _MoodAnalyticsDashboardState extends State<MoodAnalyticsDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Map<String, dynamic>? _moodTrends;
  Map<String, dynamic>? _contentCorrelation;
  List<dynamic>? _moodByTags;
  bool _isLoading = true;
  String _error = '';
  int _selectedPeriod = 7;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _loadAnalytics();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadAnalytics() async {
    try {
      setState(() => _isLoading = true);

      final results = await Future.wait([
        AnalyticsService.getMoodTrends(days: _selectedPeriod, context: context),
        AnalyticsService.getContentCorrelation(context: context),
        AnalyticsService.getMoodByTags(context: context),
      ]);

      setState(() {
        _moodTrends = results[0] as Map<String, dynamic>;
        _contentCorrelation = results[1] as Map<String, dynamic>;
        _moodByTags = results[2] as List<dynamic>;
        _isLoading = false;
        _error = '';
      });

      _animationController.forward();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localizations = AppLocalizations.of(context)!;

    if (_isLoading) {
      return _buildLoadingState(colorScheme);
    }

    if (_error.isNotEmpty) {
      return _buildErrorState(colorScheme, localizations);
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(colorScheme, localizations),
            const SizedBox(height: 24),
            _buildMoodTrendCard(colorScheme, localizations),
            const SizedBox(height: 16),
            _buildContentCorrelationCard(colorScheme, localizations),
            const SizedBox(height: 16),
            _buildMoodByTagsCard(colorScheme, localizations),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          CircularProgressIndicator(color: colorScheme.primary, strokeWidth: 3),
          const SizedBox(height: 16),
          Text(
            'Loading your insights...',
            style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    ColorScheme colorScheme,
    AppLocalizations localizations,
  ) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Icon(
            Icons.error_outline,
            size: 48,
            color: colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Unable to load analytics',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _error.contains('No authentication token') 
                ? 'Please login again'
                : 'Check your internet connection',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant.withOpacity(0.7),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: _loadAnalytics,
            icon: Icon(Icons.refresh, color: colorScheme.primary),
            label: Text(
              'Retry',
              style: TextStyle(color: colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme, AppLocalizations localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Mood Analytics',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              _buildPeriodChip(colorScheme, '7 days', 7),
              _buildPeriodChip(colorScheme, '30 days', 30),
              _buildPeriodChip(colorScheme, '90 days', 90),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodChip(ColorScheme colorScheme, String label, int days) {
    final isSelected = _selectedPeriod == days;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedPeriod = days);
        _loadAnalytics();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildMoodTrendCard(
    ColorScheme colorScheme,
    AppLocalizations localizations,
  ) {
    final averageMood = _moodTrends?['average_mood'] ?? 0.0;
    final trendDirection = _moodTrends?['trend_direction'] ?? 'stable';
    final entriesCount = _moodTrends?['entries_count'] ?? 0;

    return _buildAnimatedCard(
      colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Mood Trends',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetric(
                colorScheme,
                averageMood.toStringAsFixed(1),
                'Average',
                _getMoodColor(averageMood, colorScheme),
              ),
              _buildMetric(
                colorScheme,
                trendDirection,
                'Trend',
                _getTrendColor(trendDirection, colorScheme),
              ),
              _buildMetric(
                colorScheme,
                entriesCount.toString(),
                'Entries',
                colorScheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentCorrelationCard(
    ColorScheme colorScheme,
    AppLocalizations localizations,
  ) {
    final correlationScore = (_contentCorrelation?['correlation_score'] ?? 0.0).toDouble();
    final positiveCorrelation =
        (_contentCorrelation?['positive_words_correlation'] ?? 0.0).toDouble();
    final negativeCorrelation =
        (_contentCorrelation?['negative_words_correlation'] ?? 0.0).toDouble();

    return _buildAnimatedCard(
      colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Content Analysis',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCorrelationBar(
            colorScheme,
            'Overall Correlation',
            correlationScore,
            colorScheme.primary,
          ),
          const SizedBox(height: 12),
          _buildCorrelationBar(
            colorScheme,
            'Positive Words',
            positiveCorrelation,
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildCorrelationBar(
            colorScheme,
            'Negative Words',
            negativeCorrelation.abs(),
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildMoodByTagsCard(
    ColorScheme colorScheme,
    AppLocalizations localizations,
  ) {
    if (_moodByTags == null || _moodByTags!.isEmpty) {
      return const SizedBox();
    }

    return _buildAnimatedCard(
      colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tag, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Mood by Tags',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._moodByTags!.map((tag) => _buildTagItem(colorScheme, tag)),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(ColorScheme colorScheme, {required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(20), child: child),
    );
  }

  Widget _buildMetric(
    ColorScheme colorScheme,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildCorrelationBar(
    ColorScheme colorScheme,
    String label,
    double value,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '${(value * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value.abs(),
            backgroundColor: colorScheme.surfaceVariant.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildTagItem(ColorScheme colorScheme, dynamic tag) {
    final tagName = tag['tag'] ?? '';
    final averageMood = (tag['average_mood'] ?? 0.0).toDouble();
    final entriesCount = tag['entries_count'] ?? 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getMoodColor(averageMood, colorScheme),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tagName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  '$entriesCount entries',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            averageMood.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _getMoodColor(averageMood, colorScheme),
            ),
          ),
        ],
      ),
    );
  }

  Color _getMoodColor(double mood, ColorScheme colorScheme) {
    if (mood >= 8) return Colors.green;
    if (mood >= 6) return Colors.orange;
    return Colors.red;
  }

  Color _getTrendColor(String trend, ColorScheme colorScheme) {
    switch (trend) {
      case 'improving':
        return Colors.green;
      case 'declining':
        return Colors.red;
      default:
        return colorScheme.onSurfaceVariant;
    }
  }
}
