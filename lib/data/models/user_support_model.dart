import '../../domain/entities/user_support.dart';
import 'user_support_json_response_model.dart';

class UserSupportModel {
  UserSupportModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  final int? id;
  String name;
  final String email;
  String password;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'UserSupport{id: $id, name: $name, email: $email, password : $password}';
  }

  factory UserSupportModel.fromRemote(UserSupportModel remoteModel) =>
      UserSupportModel(
        id: remoteModel.id,
        name: remoteModel.name ,
        email: remoteModel.email,
        password: remoteModel.password,
      );

  UserSupport toEntity() => UserSupport(
        name: name,
        email: email,
        password: password,
      );
}