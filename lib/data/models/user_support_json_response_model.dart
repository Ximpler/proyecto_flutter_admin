//https://javiercbk.github.io/json_to_dart/
class user_support_json {
  int? id;
  String? name;
  String? email;
  String? password;

  user_support_json({this.id, this.name, this.email, this.password});

  user_support_json.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}