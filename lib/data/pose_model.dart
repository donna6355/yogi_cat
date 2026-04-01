class Pose {
  Pose({
    required this.id,
    required this.name,
    required this.content,
    required this.sanskrit,
  });
  String id;
  String name;
  String sanskrit;
  String content;

  factory Pose.fromJson(Map<String, dynamic> json) => Pose(
    id: json["id"],
    name: json["name"],
    content: json["content"],
    sanskrit: json["sanskrit"],
  );

  Pose copyWith({
    String? id,
    String? name,
    String? content,
    String? sanskrit,
  }) => Pose(
    id: id ?? this.id,
    name: name ?? this.name,
    content: content ?? this.content,
    sanskrit: sanskrit ?? this.sanskrit,
  );
}
