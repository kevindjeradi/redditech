class User {
  final String avatarUrl;
  final String nickname;
  final int karma;
  final String snooAvatar;
  final String description;
  User(
      {this.avatarUrl = '',
      this.nickname = '',
      this.karma = 0,
      this.snooAvatar = "",
      this.description = ""});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        avatarUrl: json["avatar"],
        nickname: json["nickname"],
        karma: json["karma"],
        snooAvatar: json["snooAvatar"],
        description: json["description"]);
  }
}
