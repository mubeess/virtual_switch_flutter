import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import '../widgets/post_preview_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_display.dart';
import '../widgets/empty_content_message.dart';
import '../widgets/search_bar_widget.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late Future<List<Post>> futurePosts;
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Post> _allPosts = [];
  List<Post> _filteredPosts = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      _allPosts = await _apiService.fetchPosts();
      _filteredPosts = [..._allPosts];
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterPosts(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        _filteredPosts = [..._allPosts];
      } else {
        _filteredPosts =
            _allPosts
                .where((post) => post.containsSearchTerm(searchTerm))
                .toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _filterPosts('');
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
      body: Column(
        children: [
          // Search bar
          SearchBarWidget(
            controller: _searchController,
            onChanged: _filterPosts,
            onClear: _clearSearch,
          ),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Found ${_filteredPosts.length} posts',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Only show "Reset" if we're filtering
                if (_searchController.text.isNotEmpty)
                  TextButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    onPressed: _clearSearch,
                  ),
              ],
            ),
          ),

          // Content section
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const LoadingIndicator();
    } else if (_errorMessage.isNotEmpty) {
      return ErrorDisplay(error: _errorMessage);
    } else if (_filteredPosts.isEmpty) {
      return EmptyContentMessage(
        message:
            _searchController.text.isEmpty
                ? 'No posts found'
                : 'No posts matching "${_searchController.text}"',
      );
    } else {
      return RefreshIndicator(
        onRefresh: _loadPosts,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: _filteredPosts.length,
          itemBuilder: (context, index) {
            final post = _filteredPosts[index];
            return PostPreviewCard(post: post);
          },
        ),
      );
    }
  }
}
