import '../entities/report.dart';

abstract class IReportRepository {
  Future<List<Report>> getReports();

  Future<bool> addReport(Report report);

  Future<bool> updateReport(Report report);

  Future<bool> deleteReport(int id);

  Future<void> deleteReports();
}