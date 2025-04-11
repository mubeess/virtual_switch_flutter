import 'package:flutter/material.dart';
import '../models/post.dart';

class UserProfileHeader extends StatelessWidget {
  final Post post;
  final double avatarRadius;
  final double fontSize;
  final bool showBookmark;
  final VoidCallback? onBookmarkPressed;

  const UserProfileHeader({
    super.key,
    required this.post,
    this.avatarRadius = 20,
    this.fontSize = 14,
    this.showBookmark = false,
    this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundColor: Colors.blue.shade100,
          foregroundColor: Colors.blue.shade800,
          child: Text(post.userId.toString()),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User ${post.userId}',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize,
                ),
              ),
              Text(
                'Post #${post.id}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: fontSize - 2,
                ),
              ),
            ],
          ),
        ),
        if (showBookmark)
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: onBookmarkPressed,
          ),
      ],
    );
  }
}
