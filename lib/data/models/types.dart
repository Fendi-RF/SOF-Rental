class Types {
  Types({
    required this.id,
    required this.typeName,
    required this.typeSlug,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String typeName;
  String typeSlug;
  DateTime createdAt;
  DateTime updatedAt;

  factory Types.fromJson(Map<String, dynamic> json) => Types(
        id: json["id"],
        typeName: json["type_name"],
        typeSlug: json["type_slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_name": typeName,
        "type_slug": typeSlug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
