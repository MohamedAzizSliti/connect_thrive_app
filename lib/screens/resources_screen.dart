import 'package:flutter/material.dart';
import 'package:connect_thrive_app/widgets/profile_app_bar.dart';
import '../l10n/app_localizations.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.resources),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: UserAvatar(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoriesSection(context),
            const SizedBox(height: 32),
            _buildFeaturedResources(context),
            const SizedBox(height: 32),
            _buildAllResources(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.categories,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryCard(
                context,
                localizations.stressManagement,
                Icons.spa,
                Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 12),
              _buildCategoryCard(
                context,
                localizations.anxiety,
                Icons.psychology,
                Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 12),
              _buildCategoryCard(
                context,
                localizations.depression,
                Icons.mood_bad,
                Theme.of(context).colorScheme.tertiary,
              ),
              const SizedBox(width: 12),
              _buildCategoryCard(
                context,
                localizations.copingSkills,
                Icons.handshake,
                Theme.of(context).colorScheme.primaryContainer,
              ),
              const SizedBox(width: 12),
              _buildCategoryCard(
                context,
                localizations.positivePsychology,
                Icons.favorite,
                Theme.of(context).colorScheme.secondaryContainer,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedResources(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.featuredResources,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildResourceCard(
          context: context,
          title: localizations.managingAnxiety,
          description: localizations.managingAnxietyDesc,
          duration: localizations.read15min,
          type: localizations.article,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 12),
        _buildResourceCard(
          context: context,
          title: localizations.breathingExercise,
          description: localizations.breathingExerciseDesc,
          duration: localizations.audio10min,
          type: localizations.audio,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }

  Widget _buildResourceCard({
    required BuildContext context,
    required String title,
    required String description,
    required String duration,
    required String type,
    required Color color,
  }) {
    final localizations = AppLocalizations.of(context)!;
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              type,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            duration,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildAllResources(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.allResources,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildResourceListItem(
          context: context,
          title: localizations.understandingDepression,
          description: localizations.understandingDepressionDesc,
          type: localizations.article,
          duration: localizations.read20min,
        ),
        const SizedBox(height: 12),
        _buildResourceListItem(
          context: context,
          title: localizations.muscleRelaxation,
          description: localizations.muscleRelaxationDesc,
          type: localizations.audio,
          duration: localizations.audio10min,
        ),
        const SizedBox(height: 12),
        _buildResourceListItem(
          context: context,
          title: localizations.buildingSelfEsteem,
          description: localizations.buildingSelfEsteemDesc,
          type: localizations.video,
          duration: localizations.video15min,
        ),
      ],
    );
  }

  Widget _buildResourceListItem({
    required BuildContext context,
    required String title,
    required String description,
    required String type,
    required String duration,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      duration,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
