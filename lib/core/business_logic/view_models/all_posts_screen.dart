import 'package:flutter/material.dart';
import 'package:posts_app/core/business_logic/models/post.dart';
import 'package:posts_app/core/services/posts/posts_service.dart';
import 'package:posts_app/core/services/service_locator.dart';
import 'base_view_model.dart';

class AllPostsScreenViewModel extends ChangeNotifier {
  // get the web api service
  PostsService _postsService = serviceLocator<PostsService>();

  List<PostPresentation> _posts = [];
  ViewState _state = ViewState.searching;

  List<PostPresentation> get posts {
    return _posts;
  }

  ViewState get state {
    return _state;
  }

  Future<void> loadData() async {
    _state = ViewState.searching;

    notifyListeners();

    List<Post> posts = await _postsService.getAllPosts();
    _posts = posts
        .map((post) => PostPresentation(
            postId: post.postId,
            title: post.title,
            isFavorite: _postsService.checkIfPostIsFavorite(post.postId)))
        .toList();

    _state = ViewState.completed;

    notifyListeners();
  }

  Future<void> toggleFavorites(int postId) async {
    int checkIndex = getIndexOfSelectedPostById(postId);
    if (_posts[checkIndex].isFavorite) {
      print("in remove");
      _posts[checkIndex].isFavorite = false;
      _removeFromFavorites(postId);
    } else {
      print("in add");
      _posts[checkIndex].isFavorite = true;
      _addToFavorites(postId);
    }

    notifyListeners();
  }

  int getIndexOfSelectedPostById(int postId) {
    int id = 0;
    for (final post in _posts) {
      if (post.postId == postId) {
        return id;
      }
      id++;
    }
    return 0;
  }

  Future<void> _addToFavorites(int postId) async {
    await _postsService.addPostToFavorites(postId);
  }

  Future<void> _removeFromFavorites(int postId) async {
    await _postsService.removeFromFavorites(postId);
  }
}

class PostPresentation {
  final String title;
  final int postId;
  bool isFavorite = false;

  PostPresentation({this.postId, this.title, this.isFavorite});
}
