import '../../../domain/entities/report.dart';

abstract class ILocalReportDataSource {
  Future<void> addOfflineReport(Report entry);

  Future<List<Report>> getCachedReports();

  Future<void> deleteReports();

  Future<void> deleteOfflineEntry(Report entry);

  Future<void> cacheReports(List<Report> reports);

  Future<List<Report>> getOfflineReports();

  Future<void> clearOfflineReports();
}