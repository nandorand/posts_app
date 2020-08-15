import 'package:posts_app/core/business_logic/models/comment.dart';
import 'package:posts_app/core/business_logic/models/post.dart';

abstract class PostsService {
  Future<List<Post>> getAllPosts();

  Future<Post> getPostById(int id);

  Future<List<Comment>> getCommentsByPostId(int postId);

  Future<List<Post>> getFavoritePosts();

  Future<void> saveFavoritePosts();

  Future<void> addPostToFavorites(int postId);

  Future<void> removeFromFavorites(int postId);

  bool checkIfPostIsFavorite(int postId);
}
