import 'package:proyecto_flutter_admin/data/models/report_db.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_flutter_admin/ui/flutter_flow/flutter_flow_util.dart';
import '../../../domain/entities/report.dart';
import 'i_local_report_datasource.dart';

class LocalReportSource implements ILocalReportDataSource {
  @override
  Future<List<Report>> getCachedReports() async {
    logInfo('getCachedReports ${Hive.box('reportDb').values.length}');
    return Hive.box('reportDb')
        .values
        .map((entry) => Report(
              id: entry.key,
              id_support: entry.id_support,
              id_client: entry.id_client,
              problem: entry.problem,
              time_started: entry.time_started,
              time_end: entry.time_end,
              calification: entry.calification,
            ))
        .toList();
  }

  @override
  Future<void> deleteReports() async {
    await Hive.box('reportDb').clear();
    await Hive.box('reportDbOffline').clear();
  }

  @override
  Future<void> deleteOfflineEntry(Report entry) async {
    await Hive.box('reportDbOffline').delete(entry.id);
  }

  @override
  Future<void> addOfflineReport(Report entry) async {
    logInfo("Adding addOfflineReport");
    await Hive.box('reportDbOffline').add(ReportDb(
        id_support: entry.id_support,
        id_client: entry.id_client,
        problem: entry.problem,
        time_started: entry.time_started,
        time_end: entry.time_end,
        calification: entry.calification));
    logInfo('addOfflineReport ${Hive.box('reportDbOffline').values.length}');
  }

  @override
  Future<void> cacheReports(List<Report> reports) async {
    logInfo('pre-cacheReports ${Hive.box('reportDb').values.length}');
    await Hive.box('reportDb').clear();
    logInfo('pre-cacheReports ${Hive.box('reportDb').values.length}');
    for (var report in reports) {
      await Hive.box('reportDb').add(ReportDb(
          id_support: report.id_support,
          id_client: report.id_client,
          problem: report.problem,
          time_started: report.time_started,
          time_end: report.time_end,
          calification: report.calification));
    }
    logInfo('cacheReports ${Hive.box('reportDb').values.length}');
  }

  @override
  Future<List<Report>> getOfflineReports() async {
    logInfo('getOfflineReports ${Hive.box('reportDbOffline').values.length}');
    return Hive.box('reportDbOffline')
        .values
        .map((entry) => Report(
            id: entry.key,
            id_support: entry.id_support,
            id_client: entry.id_client,
            problem: entry.problem,
            time_started: entry.time_started,
            time_end: entry.time_end,
            calification: entry.calification))
        .toList();
  }

  @override
  Future<void> clearOfflineReports() async {
    await Hive.box('reportDbOffline').clear();
  }
}
