import 'package:posts_app/core/business_logic/models/comment.dart';
import 'package:posts_app/core/business_logic/models/post.dart';
import 'package:posts_app/core/services/posts/posts_service.dart';
import 'package:posts_app/core/services/service_locator.dart';
import 'package:posts_app/core/services/web/web_api.dart';

class PostsServiceImpl extends PostsService {
  WebApi _webapi = serviceLocator<WebApi>();
  List<int> _favoritePostsIds = [];

  Future<List<Post>> getAllPosts() async {
    List<Post> posts = await _webapi.fetchAllPosts();
    return posts;
  }

  Future<Post> getPostById(int postId) async {
    Post post = await _webapi.fetchPostById(postId);
    return post;
  }

  Future<List<Comment>> getCommentsByPostId(int postId) async {
    List<Comment> comments = await _webapi.getCommentsByPostId(postId);
    return comments;
  }

  bool checkIfPostIsFavorite(int postId) {
    return _favoritePostsIds.contains(postId);
  }

  Future<List<Post>> getFavoritePosts() async {
    List<Post> posts = [];
    for (var i = 0; i < _favoritePostsIds.length; ++i) {
      final postId = _favoritePostsIds[i];
      Post post = await _webapi.fetchPostById(postId);
      posts.add(post);
    }
    print("here : ${posts.length}");
    return posts;
  }

  Future<void> addPostToFavorites(int postId) async {
    print("added!!!");
    _favoritePostsIds.add(postId);
    print("Now length : ${_favoritePostsIds.length}");
  }

  Future<void> removeFromFavorites(int postId) async {
    try {
      _favoritePostsIds.remove(postId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveFavoritePosts() {
    return null;
  }
}
