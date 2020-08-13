import 'package:flutter/material.dart';
import 'package:posts_app/core/services/service_locator.dart';
import 'package:posts_app/core/services/web/web_api.dart';

class PostDetailScreenViewModel extends ChangeNotifier {
  PostDetailPresentation _post = PostDetailPresentation();
  List<CommentPresentation> _comments = [];
  PostDetailViewState _postState = PostDetailViewState.searching;
  PostDetailViewState _commentState = PostDetailViewState.searching;

  WebApi _webapi = serviceLocator<WebApi>();

  PostDetailPresentation get post {
    return _post;
  }

  List<CommentPresentation> get comments {
    return _comments;
  }

  PostDetailViewState get postState {
    return _postState;
  }

  PostDetailViewState get commentState {
    return _commentState;
  }

  Future<void> loadData(int postId) async {
    final post = await _webapi.fetchPostById(postId);

    _postState = PostDetailViewState.searching;

    notifyListeners();

    _post = PostDetailPresentation(
        userId: post.userId, postTitle: post.title, postBody: post.body);

    _postState = PostDetailViewState.completed;

    notifyListeners();

    _commentState = PostDetailViewState.searching;

    notifyListeners();

    final comments = await _webapi.getCommentsByPostId(postId);
    _comments = comments
        .map((comment) => CommentPresentation(
            body: comment.body, email: comment.email, name: comment.name))
        .toList();

    _commentState = PostDetailViewState.completed;

    notifyListeners();
  }
}

enum PostDetailViewState { searching, completed }

class CommentPresentation {
  final String name;
  final String email;
  final String body;

  CommentPresentation({this.body, this.email, this.name});
}

class PostDetailPresentation {
  final int userId;
  final String postTitle;
  final String postBody;

  PostDetailPresentation({this.postBody, this.postTitle, this.userId});
}
