import 'package:flutter/material.dart';
import '../models/post.dart';
import '../models/comment.dart';
import '../services/api_service.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_display.dart';
import '../widgets/empty_content_message.dart';
import '../widgets/post_detail_card.dart';
import '../widgets/comments_section.dart';

class PostDetailScreen extends StatefulWidget {
  final int postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late Future<Post> futurePost;
  late Future<List<Comment>> futureComments;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futurePost = _apiService.fetchPost(widget.postId);
    futureComments = _apiService.fetchComments(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Post #${widget.postId}'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: FutureBuilder<Post>(
        future: futurePost,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError) {
            return ErrorDisplay(error: snapshot.error);
          } else if (!snapshot.hasData) {
            return const EmptyContentMessage(message: 'Post not found');
          } else {
            final post = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostDetailCard(post: post),
                  const SizedBox(height: 20),
                  FutureBuilder<List<Comment>>(
                    future: futureComments,
                    builder: (context, commentSnapshot) {
                      if (commentSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const LoadingIndicator();
                      } else if (commentSnapshot.hasError) {
                        return ErrorDisplay(error: commentSnapshot.error);
                      } else if (!commentSnapshot.hasData ||
                          commentSnapshot.data!.isEmpty) {
                        return const EmptyContentMessage(
                          message: 'No comments yet',
                        );
                      } else {
                        return CommentsSection(comments: commentSnapshot.data!);
                      }
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
