class Forum {
  final String id;
  final String title;
  final String description;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final bool isMember;
  final int membersCount;
  final int postsCount;

  Forum({
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isMember,
    this.membersCount = 0,
    this.postsCount = 0,
  });

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      isActive: json['is_active'] ?? true,
      isMember: json['is_member'] ?? false,
      membersCount: json['members_count'] ?? 0,
      postsCount: json['posts_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
      'is_member': isMember,
      'members_count': membersCount,
      'posts_count': postsCount,
    };
  }
}

class ForumPost {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String forumId;
  final DateTime createdAt;

  ForumPost({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.forumId,
    required this.createdAt,
  });

  factory ForumPost.fromJson(Map<String, dynamic> json) {
    return ForumPost(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      authorId: json['author_id'] ?? '',
      forumId: json['forum_id'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author_id': authorId,
      'forum_id': forumId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ForumReply {
  final String id;
  final String content;
  final String authorId;
  final String postId;
  final String? parentReplyId;
  final int depth;
  final DateTime createdAt;

  ForumReply({
    required this.id,
    required this.content,
    required this.authorId,
    required this.postId,
    this.parentReplyId,
    required this.depth,
    required this.createdAt,
  });

  factory ForumReply.fromJson(Map<String, dynamic> json) {
    return ForumReply(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      authorId: json['author_id'] ?? '',
      postId: json['post_id'] ?? '',
      parentReplyId: json['parent_reply_id'],
      depth: json['depth'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'author_id': authorId,
      'post_id': postId,
      'parent_reply_id': parentReplyId,
      'depth': depth,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class UserForum {
  final String forumId;

  UserForum({
    required this.forumId,
  });

  factory UserForum.fromJson(Map<String, dynamic> json) {
    return UserForum(
      forumId: json['forum_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'forum_id': forumId,
    };
  }
}
