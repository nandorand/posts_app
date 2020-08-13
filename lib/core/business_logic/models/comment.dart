class Comment {
  final int postId;
  final int commentId;
  final String name;
  final String email;
  final String body;

  Comment({
    this.body,
    this.commentId,
    this.email,
    this.name,
    this.postId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      body: json["body"],
      commentId: json["id"],
      postId: json["postId"],
      name: json["name"],
      email: json["email"],
    );
  }
}
