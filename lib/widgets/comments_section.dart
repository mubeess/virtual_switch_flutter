import 'package:flutter/material.dart';
import '../models/comment.dart';
import 'comment_item.dart';

class CommentsSection extends StatelessWidget {
  final List<Comment> comments;

  const CommentsSection({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...comments
                .map((comment) => CommentItem(comment: comment))
                .toList(),
          ],
        ),
      ),
    );
  }
}
