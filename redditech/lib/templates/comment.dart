class Comment {
  final String user;
  final String body;
  Comment({this.user = "", this.body = ""});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(user: json["user"], body: json["body"]);
  }
}
