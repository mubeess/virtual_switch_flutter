import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import '../widgets/post_preview_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_display.dart';
import '../widgets/empty_content_message.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late Future<List<Post>> futurePosts;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futurePosts = _apiService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError) {
            return ErrorDisplay(error: snapshot.error);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const EmptyContentMessage(message: 'No posts found');
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  futurePosts = _apiService.fetchPosts();
                });
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return PostPreviewCard(post: post);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
