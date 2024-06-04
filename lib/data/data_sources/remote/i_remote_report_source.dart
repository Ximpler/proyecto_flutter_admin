import '../../../domain/entities/report.dart';

abstract class IRemoteReportSource {
  Future<List<Report>> getReports();

  Future<bool> addReport(Report report);

  Future<bool> updateReport(Report report);

  Future<bool> deleteReport(int id);

  Future<bool> deleteReports();
}