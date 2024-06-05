import 'package:hive/hive.dart';

part 'user_support_db.g.dart';

//execute dart run build_runner build to generate the .g file

@HiveType(typeId: 2)
class UserSupportDb extends HiveObject {
  UserSupportDb({
    required this.name,
    required this.email,
    required this.password,
  });
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
}