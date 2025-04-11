import 'package:flutter/material.dart';

class ActionButtonRow extends StatelessWidget {
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;
  final VoidCallback onSharePressed;
  final int likesCount;
  final int commentsCount;

  const ActionButtonRow({
    super.key,
    required this.onLikePressed,
    required this.onCommentPressed,
    required this.onSharePressed,
    required this.likesCount,
    required this.commentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.thumb_up_outlined),
              onPressed: onLikePressed,
            ),
            Text('$likesCount', style: TextStyle(color: Colors.grey[700])),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.comment_outlined),
              onPressed: onCommentPressed,
            ),
            Text('$commentsCount', style: TextStyle(color: Colors.grey[700])),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: onSharePressed,
        ),
      ],
    );
  }
}
