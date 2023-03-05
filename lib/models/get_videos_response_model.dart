// To parse this JSON data, do
//
//     final getVideosResponseModel = getVideosResponseModelFromJson(jsonString);

class Video {
  Video({
    this.contentId,
    this.caption,
    this.thumbnail,
    this.url,
    this.views,
    this.likes,
    this.createdAt,
  });

  String? contentId;
  String? caption;
  String? thumbnail;
  String? url;
  int? views;
  int? likes;
  DateTime? createdAt;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        contentId: json["contentId"],
        caption: json["caption"],
        thumbnail: json["thumbnail"],
        url: json["url"],
        views: json["views"],
        likes: json["likes"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "contentId": contentId,
        "caption": caption,
        "thumbnail": thumbnail,
        "url": url,
        "views": views,
        "likes": likes,
        "createdAt": createdAt?.toIso8601String(),
      };
}
