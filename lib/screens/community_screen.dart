import 'package:flutter/material.dart';
import 'package:connect_thrive_app/widgets/profile_app_bar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
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
            _buildCommunityGuidelines(),
            const SizedBox(height: 24),
            _buildActiveTopics(),
            const SizedBox(height: 24),
            _buildRecentPosts(),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityGuidelines() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF6366F1).withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield, color: Color(0xFF6366F1)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Safe Space Guidelines',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Be kind, respectful, and supportive. This is a judgment-free zone.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTopics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Active Topics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildTopicCard(
          title: 'Dealing with exam stress',
          description: 'Share tips and experiences about managing academic pressure',
          participants: 24,
          posts: 18,
          lastActivity: '2 hours ago',
        ),
        const SizedBox(height: 12),
        _buildTopicCard(
          title: 'Social anxiety in school',
          description: 'Support and advice for social situations',
          participants: 31,
          posts: 42,
          lastActivity: '5 hours ago',
        ),
        const SizedBox(height: 12),
        _buildTopicCard(
          title: 'Family pressure and expectations',
          description: 'Discuss family dynamics and mental health',
          participants: 19,
          posts: 27,
          lastActivity: '1 day ago',
        ),
      ],
    );
  }

  Widget _buildTopicCard({
    required String title,
    required String description,
    required int participants,
    required int posts,
    required String lastActivity,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatItem(Icons.people, '$participants participants'),
              const SizedBox(width: 16),
              _buildStatItem(Icons.chat_bubble, '$posts posts'),
              const Spacer(),
              Text(
                lastActivity,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF64748B)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentPosts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Posts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildPostCard(
          author: 'Anonymous User',
          content: 'I\'ve been feeling really anxious about my exams lately. Does anyone have tips for managing test anxiety?',
          topic: 'Dealing with exam stress',
          time: '2 hours ago',
          replies: 5,
        ),
        const SizedBox(height: 12),
        _buildPostCard(
          author: 'Hopeful Teen',
          content: 'Just wanted to share that I\'ve been using the breathing exercises from this app and they\'ve really helped me stay calm during stressful moments.',
          topic: 'Success Stories',
          time: '4 hours ago',
          replies: 8,
        ),
      ],
    );
  }

  Widget _buildPostCard({
    required String author,
    required String content,
    required String topic,
    required String time,
    required int replies,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF6366F1),
                child: Icon(Icons.person, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    author,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    topic,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.chat_bubble_outline, size: 16, color: Color(0xFF64748B)),
              const SizedBox(width: 4),
              Text(
                '$replies replies',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Reply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
