class UserSupport {
  UserSupport({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  int? id;
  String name;
  String email;
  String password;

  String get emailAddress => email;

  factory UserSupport.fromJson(Map<String, dynamic> json) => UserSupport(
        id: json["id"],
        name: json["name"] ?? "someName",
        email: json["email"] ?? "someEmail",
        password: json["password"] ?? "somePassword",
      );

  Map<String, dynamic> toJson() => {
        //"id": id ?? 0, // id is not required when adding a new user
        "name": name,
        "email": email,
        "password": password,
      };
}