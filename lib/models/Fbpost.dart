class Fbpost {
  Fbpost({
    required this.id,
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isVerified,
    required this.avatarUrl,
    required this.audience,
  });

  final int? id;
  final String? username;
  final String? timeAgo;
  final String? content;
  final String? imageUrl;
  final int? likes;
  final int? comments;
  final int? shares;
  final bool? isVerified;
  final String? avatarUrl;
  final String? audience;

  factory Fbpost.fromJson(Map<String, dynamic> json){
    return Fbpost(
      id: json["id"],
      username: json["username"],
      timeAgo: json["timeAgo"],
      content: json["content"],
      imageUrl: json["imageUrl"],
      likes: json["likes"],
      comments: json["comments"],
      shares: json["shares"],
      isVerified: json["isVerified"],
      avatarUrl: json["avatarUrl"],
      audience: json["audience"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "timeAgo": timeAgo,
    "content": content,
    "imageUrl": imageUrl,
    "likes": likes,
    "comments": comments,
    "shares": shares,
    "isVerified": isVerified,
    "avatarUrl": avatarUrl,
    "audience": audience,
  };

}
