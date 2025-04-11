import 'package:flutter/material.dart';
import '../models/post.dart';
import 'blue_header_bar.dart';
import 'user_profile_header.dart';
import 'action_button_row.dart';

class PostDetailCard extends StatelessWidget {
  final Post post;

  const PostDetailCard({super.key, required this.post});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BlueHeaderBar(
            height: 12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfileHeader(
                  post: post,
                  avatarRadius: 24,
                  fontSize: 16,
                  showBookmark: true,
                  onBookmarkPressed:
                      () =>
                          _showSnackBar(context, 'Post ${post.id} bookmarked!'),
                ),
                const SizedBox(height: 24),
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  post.body,
                  style: TextStyle(
                    color: Colors.grey[800],
                    height: 1.5,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 8),
                ActionButtonRow(
                  onLikePressed: () => _showSnackBar(context, 'Post liked!'),
                  onCommentPressed:
                      () => _showSnackBar(context, 'Comments displayed below'),
                  onSharePressed:
                      () =>
                          _showSnackBar(context, 'Share feature coming soon!'),
                  likesCount: post.id + 10, // Fake likes count
                  commentsCount: 5, // Fake comments count
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
