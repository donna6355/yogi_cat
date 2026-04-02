class Sanskrit {
  Sanskrit({
    required this.id,
    required this.sanskrit,
    required this.meaning,
    required this.asanaIds,
  });
  String id;
  String sanskrit;
  String meaning;
  List<String> asanaIds;

  factory Sanskrit.fromJson(Map<String, dynamic> json) => Sanskrit(
    id: json["id"],
    meaning: json["meaning"],
    asanaIds: json["asanaIds"],
    sanskrit: json["sanskrit"],
  );

  Sanskrit copyWith({
    String? id,
    String? meaning,
    List<String>? asanaIds,
    String? sanskrit,
  }) => Sanskrit(
    id: id ?? this.id,
    meaning: meaning ?? this.meaning,
    asanaIds: asanaIds ?? this.asanaIds,
    sanskrit: sanskrit ?? this.sanskrit,
  );
}
