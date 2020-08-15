import 'package:flutter/material.dart';
import 'package:posts_app/core/business_logic/models/post.dart';
import 'package:posts_app/core/business_logic/view_models/base_view_model.dart';
import 'package:posts_app/core/services/posts/posts_service.dart';
import 'package:posts_app/core/services/service_locator.dart';

class FavoriteScreenViewModel extends ChangeNotifier {
  PostsService _postsService = serviceLocator<PostsService>();
  List<FavoritePostsPresentation> _favoritePostsPresentation = [];
  ViewState _state = ViewState.searching;

  List<FavoritePostsPresentation> get favoritePosts {
    return _favoritePostsPresentation;
  }

  ViewState get state {
    return _state;
  }

  Future<void> loadData() async {
    _state = ViewState.searching;

    notifyListeners();

    List<Post> favoritePosts = await _postsService.getFavoritePosts();
    _favoritePostsPresentation = favoritePosts
        .map((post) =>
            FavoritePostsPresentation(postId: post.postId, title: post.title))
        .toList();

    _state = ViewState.completed;

    notifyListeners();
  }

  Future<void> removeFromFavorite(int postId) async {
    _state = ViewState.searching;

    notifyListeners();

    await _postsService.removeFromFavorites(postId);

    List<Post> favoritePosts = await _postsService.getFavoritePosts();
    _favoritePostsPresentation = favoritePosts
        .map((post) =>
            FavoritePostsPresentation(postId: post.postId, title: post.title))
        .toList();

    _state = ViewState.completed;

    notifyListeners();
  }
}

class FavoritePostsPresentation {
  final String title;
  final int postId;

  FavoritePostsPresentation({this.postId, this.title});
}
