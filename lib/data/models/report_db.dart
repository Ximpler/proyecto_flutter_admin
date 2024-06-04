import 'package:hive/hive.dart';

part 'report_db.g.dart';

//execute dart run build_runner build to generate the .g file

@HiveType(typeId: 1)
class ReportDb extends HiveObject {
  ReportDb({
    required this.id_support,
    required this.id_client,
    required this.problem,
    required this.time_started,
    required this.time_end,
  });
  @HiveField(0)
  int id_support;
  @HiveField(1)
  int id_client;
  @HiveField(2)
  String problem;
  @HiveField(3)
  DateTime time_started;
  @HiveField(4)
  DateTime time_end;
}