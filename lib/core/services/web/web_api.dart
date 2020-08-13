import 'package:posts_app/core/business_logic/models/comment.dart';
import 'package:posts_app/core/business_logic/models/post.dart';

abstract class WebApi {
  Future<List<Post>> fetchAllPosts();

  Future<Post> fetchPostById(int postId);

  Future<List<Comment>> getCommentsByPostId(int postId);
}
