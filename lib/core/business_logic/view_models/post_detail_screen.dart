import 'package:flutter/material.dart';
import 'package:posts_app/core/services/posts/posts_service.dart';
import 'package:posts_app/core/services/service_locator.dart';
import 'base_view_model.dart';

class PostDetailScreenViewModel extends ChangeNotifier {
  PostDetailPresentation _post = PostDetailPresentation();
  List<CommentPresentation> _comments = [];
  ViewState _postState = ViewState.searching;
  ViewState _commentState = ViewState.searching;

  PostsService _postsService = serviceLocator<PostsService>();

  PostDetailPresentation get post {
    return _post;
  }

  List<CommentPresentation> get comments {
    return _comments;
  }

  ViewState get postState {
    return _postState;
  }

  ViewState get commentState {
    return _commentState;
  }

  Future<void> loadData(int postId) async {
    final post = await _postsService.getPostById(postId);

    _postState = ViewState.searching;

    notifyListeners();

    _post = PostDetailPresentation(
        userId: post.userId, postTitle: post.title, postBody: post.body);

    _postState = ViewState.completed;

    notifyListeners();

    _commentState = ViewState.searching;

    notifyListeners();

    final comments = await _postsService.getCommentsByPostId(postId);
    _comments = comments
        .map((comment) => CommentPresentation(
            body: comment.body, email: comment.email, name: comment.name))
        .toList();

    _commentState = ViewState.completed;

    notifyListeners();
  }
}

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
