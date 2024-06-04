class NormalUser {
  NormalUser({
    this.id,
    required this.name,
  });

  int? id;
  String name;


  factory NormalUser.fromJson(Map<String, dynamic> json) => NormalUser(
        id: json["id"],
        name: json["name"] ?? "someName",
      );

  Map<String, dynamic> toJson() => {
        //"id": id ?? 0, // id is not required when adding a new user
        "name": name,
      };
}