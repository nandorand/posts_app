import 'package:posts_app/core/business_logic/models/post.dart';

abstract class WebApi {
  Future<List<Post>> fetchAllPosts();
}
