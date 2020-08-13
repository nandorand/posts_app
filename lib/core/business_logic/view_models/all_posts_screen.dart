import 'package:flutter/material.dart';
import 'package:posts_app/core/business_logic/models/post.dart';
import 'package:posts_app/core/services/service_locator.dart';
import 'package:posts_app/core/services/web/web_api.dart';

class AllPostsScreenViewModel extends ChangeNotifier {
  // get the web api service
  WebApi _webapi = serviceLocator<WebApi>();

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

    List<Post> posts = await _webapi.fetchAllPosts();
    _posts = posts
        .map((post) => PostPresentation(postId: post.postId, title: post.body))
        .toList();

    _state = ViewState.completed;

    notifyListeners();
  }
}

enum ViewState { searching, completed }

class PostPresentation {
  final String title;
  final int postId;

  PostPresentation({this.postId, this.title});
}
