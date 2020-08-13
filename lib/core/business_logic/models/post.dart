class Post {
  final int userId;
  final int postId;
  final String title;
  final String body;

  Post({this.title, this.body, this.postId, this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        title: json["title"],
        body: json["body"],
        postId: json["id"],
        userId: json["userId"]);
  }
}
